-- Drop existing policies first to avoid conflicts
DO $$ 
BEGIN
  DROP POLICY IF EXISTS "View own admin roles" ON public.court_administrators;
  DROP POLICY IF EXISTS "Chief judge view all admins" ON public.court_administrators;
  DROP POLICY IF EXISTS "Judge view court admins" ON public.court_administrators;
END $$;

-- Create court administrators table with role as text
CREATE TABLE IF NOT EXISTS public.court_administrators (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  court_location_id uuid REFERENCES public.court_locations(id) ON DELETE CASCADE NOT NULL,
  role text NOT NULL CHECK (role IN ('chief_judge', 'judge', 'administrator')),
  granted_by uuid REFERENCES public.profiles(id),
  granted_at timestamptz DEFAULT now(),
  revoked_at timestamptz,
  is_active boolean DEFAULT true,
  UNIQUE(user_id, court_location_id, role)
);

-- Enable RLS
ALTER TABLE public.court_administrators ENABLE ROW LEVEL SECURITY;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_court_admins_user ON court_administrators(user_id);
CREATE INDEX IF NOT EXISTS idx_court_admins_court ON court_administrators(court_location_id);
CREATE INDEX IF NOT EXISTS idx_court_admins_active ON court_administrators(is_active);
CREATE INDEX IF NOT EXISTS idx_court_admins_role ON court_administrators(role) WHERE is_active = true;

-- Create materialized view for active administrators
CREATE MATERIALIZED VIEW IF NOT EXISTS active_court_admins AS
SELECT DISTINCT 
  user_id,
  court_location_id,
  role
FROM public.court_administrators
WHERE is_active = true 
AND revoked_at IS NULL;

-- Create index on materialized view
CREATE UNIQUE INDEX IF NOT EXISTS idx_active_admins ON active_court_admins(user_id, court_location_id, role);

-- Create function to refresh active admins view
CREATE OR REPLACE FUNCTION refresh_active_admins()
RETURNS trigger AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY active_court_admins;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to refresh view
DROP TRIGGER IF EXISTS refresh_active_admins_trigger ON public.court_administrators;
CREATE TRIGGER refresh_active_admins_trigger
AFTER INSERT OR UPDATE OR DELETE ON public.court_administrators
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_active_admins();

-- Create function to check if user is court administrator
CREATE OR REPLACE FUNCTION is_court_administrator(court_id uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM active_court_admins
    WHERE user_id = auth.uid()
    AND court_location_id = court_id
  );
$$;

-- Create function to check if user is chief judge
CREATE OR REPLACE FUNCTION is_chief_judge(court_id uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM active_court_admins
    WHERE user_id = auth.uid()
    AND court_location_id = court_id
    AND role = 'chief_judge'
  );
$$;

-- Create function to check if user is judge
CREATE OR REPLACE FUNCTION is_judge(court_id uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM active_court_admins
    WHERE user_id = auth.uid()
    AND court_location_id = court_id
    AND role = 'judge'
  );
$$;

-- Create simplified policies using materialized view
CREATE POLICY "Users can view their own roles"
  ON public.court_administrators
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "Admins can view roles for their court"
  ON public.court_administrators
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 
      FROM active_court_admins
      WHERE user_id = auth.uid()
      AND court_location_id = court_administrators.court_location_id
      AND role IN ('chief_judge', 'judge')
    )
  );

-- Add OAuth provider columns to profiles if they don't exist
ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS oauth_providers jsonb DEFAULT '[]'::jsonb,
ADD COLUMN IF NOT EXISTS oauth_id text;

-- Create index for OAuth lookups
CREATE INDEX IF NOT EXISTS idx_profiles_oauth_id ON profiles(oauth_id);

-- Do initial refresh of materialized view
REFRESH MATERIALIZED VIEW active_court_admins;