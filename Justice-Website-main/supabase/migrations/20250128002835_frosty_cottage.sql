-- First drop policies that depend on role_assignments
DO $$ 
BEGIN
  DROP POLICY IF EXISTS "View own roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Manage roles as admin" ON public.user_roles;
END $$;

-- Now we can safely drop the materialized views
DROP MATERIALIZED VIEW IF EXISTS role_assignments CASCADE;
DROP MATERIALIZED VIEW IF EXISTS user_role_cache CASCADE;
DROP MATERIALIZED VIEW IF EXISTS active_court_admins CASCADE;

-- Create new role_assignments view
CREATE MATERIALIZED VIEW role_assignments AS
SELECT DISTINCT 
  ur.user_id,
  r.name as role_name,
  ur.role_id
FROM public.user_roles ur
JOIN public.roles r ON r.id = ur.role_id;

-- Create necessary indexes
CREATE UNIQUE INDEX idx_role_assignments_user_role ON role_assignments(user_id, role_name);
CREATE INDEX idx_role_assignments_role_id ON role_assignments(role_id);

-- Create refresh function
CREATE OR REPLACE FUNCTION refresh_role_assignments()
RETURNS trigger AS $$
DECLARE
  v_lock_obtained boolean;
BEGIN
  -- Try to obtain lock
  v_lock_obtained := pg_try_advisory_lock(hashtext('refresh_role_assignments'::text)::bigint);
  
  IF v_lock_obtained THEN
    BEGIN
      REFRESH MATERIALIZED VIEW CONCURRENTLY role_assignments;
      PERFORM pg_advisory_unlock(hashtext('refresh_role_assignments'::text)::bigint);
    EXCEPTION WHEN OTHERS THEN
      PERFORM pg_advisory_unlock(hashtext('refresh_role_assignments'::text)::bigint);
      RAISE;
    END;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for automatic refresh
DROP TRIGGER IF EXISTS refresh_role_assignments_trigger ON public.user_roles;
CREATE TRIGGER refresh_role_assignments_trigger
AFTER INSERT OR UPDATE OR DELETE ON public.user_roles
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_role_assignments();

-- Update all policies to use direct joins
DO $$ 
BEGIN
  -- Drop existing policies
  DROP POLICY IF EXISTS "Administrators can view all profiles" ON public.profiles;
  DROP POLICY IF EXISTS "Only administrators can view bank accounts" ON public.bank_accounts;
  DROP POLICY IF EXISTS "Only administrators can manage bank accounts" ON public.bank_accounts;
  DROP POLICY IF EXISTS "Administrators can manage calendar events" ON public.court_calendars;
  DROP POLICY IF EXISTS "Administrators can manage all appointments" ON public.court_appointments;
  DROP POLICY IF EXISTS "Allow admin management of court locations" ON public.court_locations;
  DROP POLICY IF EXISTS "Allow admin and clerk management of court rooms" ON public.court_rooms;

  -- Create new policies using direct joins
  CREATE POLICY "Administrators can view all profiles"
    ON public.profiles
    FOR ALL
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 FROM public.user_roles ur
        JOIN public.roles r ON ur.role_id = r.id
        WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
      )
    );

  CREATE POLICY "Only administrators can view bank accounts"
    ON public.bank_accounts
    FOR SELECT
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 FROM public.user_roles ur
        JOIN public.roles r ON ur.role_id = r.id
        WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
      )
    );

  CREATE POLICY "Only administrators can manage bank accounts"
    ON public.bank_accounts
    FOR ALL
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 FROM public.user_roles ur
        JOIN public.roles r ON ur.role_id = r.id
        WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
      )
    );

  CREATE POLICY "Administrators can manage calendar events"
    ON public.court_calendars
    FOR ALL
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 FROM public.user_roles ur
        JOIN public.roles r ON ur.role_id = r.id
        WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
      )
    );

  CREATE POLICY "Administrators can manage all appointments"
    ON public.court_appointments
    FOR ALL
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 FROM public.user_roles ur
        JOIN public.roles r ON ur.role_id = r.id
        WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
      )
    );

  CREATE POLICY "Allow admin management of court locations"
    ON public.court_locations
    FOR ALL
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 FROM public.user_roles ur
        JOIN public.roles r ON ur.role_id = r.id
        WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
      )
    );

  CREATE POLICY "Allow admin and clerk management of court rooms"
    ON public.court_rooms
    FOR ALL
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 FROM public.user_roles ur
        JOIN public.roles r ON ur.role_id = r.id
        WHERE ur.user_id = auth.uid() AND r.name IN ('administrator', 'clerk')
      )
    );
END $$;

-- Create new policies for user_roles using role_assignments
CREATE POLICY "View own roles"
  ON public.user_roles
  FOR SELECT
  TO authenticated
  USING (
    user_id = auth.uid() OR 
    EXISTS (
      SELECT 1 
      FROM role_assignments 
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
      FROM role_assignments 
      WHERE user_id = auth.uid() 
      AND role_name = 'administrator'
    )
    AND user_id != auth.uid()
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 
      FROM role_assignments 
      WHERE user_id = auth.uid() 
      AND role_name = 'administrator'
    )
    AND user_id != auth.uid()
  );

-- Update user_has_role function
CREATE OR REPLACE FUNCTION public.user_has_role(role_name text)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM role_assignments
    WHERE user_id = auth.uid()
    AND role_name = $1
  );
$$;

-- Do initial refresh of materialized view
REFRESH MATERIALIZED VIEW role_assignments;