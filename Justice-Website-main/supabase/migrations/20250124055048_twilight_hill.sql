/*
  # Fix Role Policies and Recursion

  This migration:
  1. Drops and recreates user_roles policies with a simpler approach
  2. Uses a materialized admin check to prevent recursion
  3. Adds a function to safely check admin status
  
  Security:
  - Maintains proper access control
  - Eliminates recursive policy checks
  - Preserves administrator privileges
*/

-- Create a function to check admin status without recursion
CREATE OR REPLACE FUNCTION is_admin()
RETURNS boolean
LANGUAGE sql SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.roles r
    JOIN public.user_roles ur ON r.id = ur.role_id
    WHERE ur.user_id = auth.uid()
    AND r.name = 'administrator'
  );
$$;

-- Drop existing policies
DO $$ 
BEGIN
  DROP POLICY IF EXISTS "Users can view their own roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can manage all roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can view all roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can insert roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can delete roles" ON public.user_roles;
END $$;

-- Create new simplified policies
CREATE POLICY "View own roles"
  ON public.user_roles
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid() OR is_admin());

CREATE POLICY "Manage roles as admin"
  ON public.user_roles
  FOR ALL
  TO authenticated
  USING (
    is_admin() -- Check if user is admin
    AND user_id != auth.uid() -- Prevent modifying own roles
  )
  WITH CHECK (
    is_admin() -- Check if user is admin
    AND user_id != auth.uid() -- Prevent modifying own roles
  );

-- Update the user_has_role function to use direct join
CREATE OR REPLACE FUNCTION public.user_has_role(role_name text)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.roles r
    JOIN public.user_roles ur ON r.id = ur.role_id
    WHERE ur.user_id = auth.uid()
    AND r.name = role_name
  );
$$;