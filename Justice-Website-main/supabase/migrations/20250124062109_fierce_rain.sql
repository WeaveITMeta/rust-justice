-- Drop existing policies that might cause recursion
DO $$ 
BEGIN
  DROP POLICY IF EXISTS "View own roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Manage roles as admin" ON public.user_roles;
END $$;

-- Create a materialized view to cache admin roles for better performance
CREATE MATERIALIZED VIEW IF NOT EXISTS admin_users AS
SELECT DISTINCT ur.user_id
FROM public.user_roles ur
JOIN public.roles r ON r.id = ur.role_id
WHERE r.name = 'administrator';

-- Create index for better performance
CREATE INDEX IF NOT EXISTS idx_admin_users_user_id ON admin_users(user_id);

-- Create function to refresh admin users
CREATE OR REPLACE FUNCTION refresh_admin_users()
RETURNS trigger AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY admin_users;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to refresh admin users view
DROP TRIGGER IF EXISTS refresh_admin_users_trigger ON public.user_roles;
CREATE TRIGGER refresh_admin_users_trigger
AFTER INSERT OR UPDATE OR DELETE ON public.user_roles
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_admin_users();

-- Create simplified policies without recursion
CREATE POLICY "View own roles"
  ON public.user_roles
  FOR SELECT
  TO authenticated
  USING (
    user_id = auth.uid() OR 
    EXISTS (SELECT 1 FROM admin_users WHERE user_id = auth.uid())
  );

CREATE POLICY "Manage roles as admin"
  ON public.user_roles
  FOR ALL
  TO authenticated
  USING (
    EXISTS (SELECT 1 FROM admin_users WHERE user_id = auth.uid())
    AND user_id != auth.uid() -- Prevent modifying own roles
  )
  WITH CHECK (
    EXISTS (SELECT 1 FROM admin_users WHERE user_id = auth.uid())
    AND user_id != auth.uid() -- Prevent modifying own roles
  );

-- Update user_has_role function to use materialized view
CREATE OR REPLACE FUNCTION public.user_has_role(role_name text)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT 
    CASE 
      WHEN role_name = 'administrator' THEN
        EXISTS (SELECT 1 FROM admin_users WHERE user_id = auth.uid())
      ELSE
        EXISTS (
          SELECT 1
          FROM public.roles r
          JOIN public.user_roles ur ON r.id = ur.role_id
          WHERE ur.user_id = auth.uid()
          AND r.name = role_name
        )
    END;
$$;

-- Do initial refresh of admin users view
REFRESH MATERIALIZED VIEW admin_users;