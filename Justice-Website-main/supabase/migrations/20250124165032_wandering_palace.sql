/*
  # Court Administrator Setup
  
  1. Tables
    - Create court administrators table with role as text
    - Add indexes for performance
  
  2. Security
    - Enable RLS
    - Drop existing policies to avoid conflicts
    - Add new policies for access control
  
  3. OAuth Support
    - Add OAuth provider fields to profiles
    - Add OAuth lookup index
*/

-- Drop existing policies first to avoid conflicts
DO $$ 
BEGIN
  DROP POLICY IF EXISTS "Administrators can view their own roles" ON public.court_administrators;
  DROP POLICY IF EXISTS "Chief judges can view all court administrators" ON public.court_administrators;
  DROP POLICY IF EXISTS "Judges can view court administrators" ON public.court_administrators;
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

-- Create function to check if user is court administrator
CREATE OR REPLACE FUNCTION is_court_administrator(court_id uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.court_administrators
    WHERE user_id = auth.uid()
    AND court_location_id = court_id
    AND is_active = true
    AND revoked_at IS NULL
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
    FROM public.court_administrators
    WHERE user_id = auth.uid()
    AND court_location_id = court_id
    AND role = 'chief_judge'
    AND is_active = true
    AND revoked_at IS NULL
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
    FROM public.court_administrators
    WHERE user_id = auth.uid()
    AND court_location_id = court_id
    AND role = 'judge'
    AND is_active = true
    AND revoked_at IS NULL
  );
$$;

-- Create new policies with unique names
CREATE POLICY "View own admin roles"
  ON public.court_administrators
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "Chief judge view all admins"
  ON public.court_administrators
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 
      FROM public.court_administrators
      WHERE user_id = auth.uid()
      AND court_location_id = court_location_id
      AND role = 'chief_judge'
      AND is_active = true
      AND revoked_at IS NULL
    )
  );

CREATE POLICY "Judge view court admins"
  ON public.court_administrators
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 
      FROM public.court_administrators
      WHERE user_id = auth.uid()
      AND court_location_id = court_location_id
      AND role = 'judge'
      AND is_active = true
      AND revoked_at IS NULL
    )
  );

-- Add OAuth provider columns to profiles if they don't exist
ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS oauth_providers jsonb DEFAULT '[]'::jsonb,
ADD COLUMN IF NOT EXISTS oauth_id text;

-- Create index for OAuth lookups
CREATE INDEX IF NOT EXISTS idx_profiles_oauth_id ON profiles(oauth_id);