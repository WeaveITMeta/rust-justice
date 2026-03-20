-- Drop existing policies and functions that might cause recursion
DO $$ 
BEGIN
  DROP POLICY IF EXISTS "View own roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Manage roles as admin" ON public.user_roles;
  DROP POLICY IF EXISTS "Users can view their own roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can manage user roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can view all roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can insert roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can delete roles" ON public.user_roles;
END $$;

-- Create a base roles view for better performance
CREATE MATERIALIZED VIEW IF NOT EXISTS user_role_cache AS
SELECT DISTINCT 
  ur.user_id,
  r.name as role_name
FROM public.user_roles ur
JOIN public.roles r ON r.id = ur.role_id;

-- Create index for better performance
CREATE INDEX IF NOT EXISTS idx_user_role_cache_user_id ON user_role_cache(user_id);
CREATE INDEX IF NOT EXISTS idx_user_role_cache_role_name ON user_role_cache(role_name);

-- Create function to refresh role cache
CREATE OR REPLACE FUNCTION refresh_role_cache()
RETURNS trigger AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY user_role_cache;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to refresh role cache
DROP TRIGGER IF EXISTS refresh_role_cache_trigger ON public.user_roles;
CREATE TRIGGER refresh_role_cache_trigger
AFTER INSERT OR UPDATE OR DELETE ON public.user_roles
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_role_cache();

-- Create simplified policies using the cache
CREATE POLICY "View own roles"
  ON public.user_roles
  FOR SELECT
  TO authenticated
  USING (
    user_id = auth.uid() OR 
    EXISTS (
      SELECT 1 
      FROM user_role_cache 
      WHERE user_id = auth.uid() 
      AND role_name = 'administrator'
    )
  );

CREATE POLICY "Manage roles as admin"
  ON public.user_roles
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 
      FROM user_role_cache 
      WHERE user_id = auth.uid() 
      AND role_name = 'administrator'
    )
    AND user_id != auth.uid() -- Prevent modifying own roles
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 
      FROM user_role_cache 
      WHERE user_id = auth.uid() 
      AND role_name = 'administrator'
    )
    AND user_id != auth.uid() -- Prevent modifying own roles
  );

-- Update user_has_role function to use the cache
CREATE OR REPLACE FUNCTION public.user_has_role(role_name text)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM user_role_cache
    WHERE user_id = auth.uid()
    AND role_name = $1
  );
$$;

-- Do initial refresh of role cache
REFRESH MATERIALIZED VIEW user_role_cache;

-- Update all other policies to use the role cache
DO $$ 
BEGIN
  -- Profiles policies
  DROP POLICY IF EXISTS "Administrators can view all profiles" ON public.profiles;
  CREATE POLICY "Administrators can view all profiles"
    ON public.profiles
    FOR ALL
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 
        FROM user_role_cache 
        WHERE user_id = auth.uid() 
        AND role_name = 'administrator'
      )
    );

  -- Bank accounts policies
  DROP POLICY IF EXISTS "Only administrators can view bank accounts" ON public.bank_accounts;
  DROP POLICY IF EXISTS "Only administrators can manage bank accounts" ON public.bank_accounts;
  
  CREATE POLICY "Only administrators can view bank accounts"
    ON public.bank_accounts
    FOR SELECT
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 
        FROM user_role_cache 
        WHERE user_id = auth.uid() 
        AND role_name = 'administrator'
      )
    );

  CREATE POLICY "Only administrators can manage bank accounts"
    ON public.bank_accounts
    FOR ALL
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 
        FROM user_role_cache 
        WHERE user_id = auth.uid() 
        AND role_name = 'administrator'
      )
    );

  -- Traffic tickets policies
  DROP POLICY IF EXISTS "Administrators can view all tickets" ON public.traffic_tickets;
  CREATE POLICY "Administrators can view all tickets"
    ON public.traffic_tickets
    FOR SELECT
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 
        FROM user_role_cache 
        WHERE user_id = auth.uid() 
        AND role_name = 'administrator'
      )
    );

  -- Court calendars policies
  DROP POLICY IF EXISTS "Administrators can manage calendar events" ON public.court_calendars;
  CREATE POLICY "Administrators can manage calendar events"
    ON public.court_calendars
    FOR ALL
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 
        FROM user_role_cache 
        WHERE user_id = auth.uid() 
        AND role_name = 'administrator'
      )
    );

  -- Court appointments policies
  DROP POLICY IF EXISTS "Administrators can manage all appointments" ON public.court_appointments;
  CREATE POLICY "Administrators can manage all appointments"
    ON public.court_appointments
    FOR ALL
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 
        FROM user_role_cache 
        WHERE user_id = auth.uid() 
        AND role_name = 'administrator'
      )
    );

  -- Court locations policies
  DROP POLICY IF EXISTS "Allow admin management of court locations" ON public.court_locations;
  CREATE POLICY "Allow admin management of court locations"
    ON public.court_locations
    FOR ALL
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 
        FROM user_role_cache 
        WHERE user_id = auth.uid() 
        AND role_name = 'administrator'
      )
    );
END $$;