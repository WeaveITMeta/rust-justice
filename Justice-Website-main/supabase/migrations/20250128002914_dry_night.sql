-- First drop policies that depend on materialized views
DO $$ 
BEGIN
  -- Drop policies from user_roles
  DROP POLICY IF EXISTS "View own roles" ON public.user_roles CASCADE;
  DROP POLICY IF EXISTS "Manage roles as admin" ON public.user_roles CASCADE;
  DROP POLICY IF EXISTS "Users can view own roles" ON public.user_roles CASCADE;
  DROP POLICY IF EXISTS "Administrators can manage roles" ON public.user_roles CASCADE;

  -- Drop policies from other tables
  DROP POLICY IF EXISTS "Administrators can view all profiles" ON public.profiles CASCADE;
  DROP POLICY IF EXISTS "Only administrators can view bank accounts" ON public.bank_accounts CASCADE;
  DROP POLICY IF EXISTS "Only administrators can manage bank accounts" ON public.bank_accounts CASCADE;
  DROP POLICY IF EXISTS "Administrators can manage calendar events" ON public.court_calendars CASCADE;
  DROP POLICY IF EXISTS "Administrators can manage all appointments" ON public.court_appointments CASCADE;
  DROP POLICY IF EXISTS "Allow admin management of court locations" ON public.court_locations CASCADE;
  DROP POLICY IF EXISTS "Allow admin and clerk management of court rooms" ON public.court_rooms CASCADE;
END $$;

-- Now we can safely drop the materialized views
DROP MATERIALIZED VIEW IF EXISTS role_assignments CASCADE;
DROP MATERIALIZED VIEW IF EXISTS user_role_cache CASCADE;
DROP MATERIALIZED VIEW IF EXISTS active_court_admins CASCADE;

-- Create admin check function for reuse
CREATE OR REPLACE FUNCTION is_admin()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles ur
    JOIN public.roles r ON ur.role_id = r.id
    WHERE ur.user_id = auth.uid()
    AND r.name = 'administrator'
  );
$$;

-- Create new policies using the admin check function
DO $$ 
BEGIN
  -- Create profiles policies
  CREATE POLICY "Administrators can view all profiles"
    ON public.profiles
    FOR ALL
    TO authenticated
    USING (is_admin() OR id = auth.uid());

  -- Create bank accounts policies
  CREATE POLICY "Only administrators can view bank accounts"
    ON public.bank_accounts
    FOR SELECT
    TO authenticated
    USING (is_admin());

  CREATE POLICY "Only administrators can manage bank accounts"
    ON public.bank_accounts
    FOR ALL
    TO authenticated
    USING (is_admin());

  -- Create court calendars policy
  CREATE POLICY "Administrators can manage calendar events"
    ON public.court_calendars
    FOR ALL
    TO authenticated
    USING (is_admin());

  -- Create court appointments policy
  CREATE POLICY "Administrators can manage all appointments"
    ON public.court_appointments
    FOR ALL
    TO authenticated
    USING (is_admin());

  -- Create court locations policy
  CREATE POLICY "Allow admin management of court locations"
    ON public.court_locations
    FOR ALL
    TO authenticated
    USING (is_admin());

  -- Create court rooms policy
  CREATE POLICY "Allow admin and clerk management of court rooms"
    ON public.court_rooms
    FOR ALL
    TO authenticated
    USING (
      EXISTS (
        SELECT 1 FROM public.user_roles ur
        JOIN public.roles r ON ur.role_id = r.id
        WHERE ur.user_id = auth.uid()
        AND r.name IN ('administrator', 'clerk')
      )
    );

  -- Create user roles policies
  CREATE POLICY "View own roles"
    ON public.user_roles
    FOR SELECT
    TO authenticated
    USING (user_id = auth.uid() OR is_admin());

  CREATE POLICY "Manage roles as admin"
    ON public.user_roles
    FOR ALL
    TO authenticated
    USING (is_admin() AND user_id != auth.uid())
    WITH CHECK (is_admin() AND user_id != auth.uid());
END $$;

-- Update user_has_role function to use direct check
CREATE OR REPLACE FUNCTION public.user_has_role(role_name text)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles ur
    JOIN public.roles r ON ur.role_id = r.id
    WHERE ur.user_id = auth.uid()
    AND r.name = role_name
  );
$$;