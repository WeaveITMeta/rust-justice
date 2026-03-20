-- Create a new materialized view for caching role assignments
CREATE MATERIALIZED VIEW IF NOT EXISTS role_assignments AS
SELECT DISTINCT 
  ur.user_id,
  r.name as role_name
FROM public.user_roles ur
JOIN public.roles r ON r.id = ur.role_id;

-- Create unique index for better performance
CREATE UNIQUE INDEX IF NOT EXISTS idx_role_assignments_user_role 
ON role_assignments(user_id, role_name);

-- Create function to refresh role assignments
CREATE OR REPLACE FUNCTION refresh_role_assignments()
RETURNS trigger AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY role_assignments;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to refresh role assignments
DROP TRIGGER IF EXISTS refresh_role_assignments_trigger ON public.user_roles;
CREATE TRIGGER refresh_role_assignments_trigger
AFTER INSERT OR UPDATE OR DELETE ON public.user_roles
FOR EACH STATEMENT
EXECUTE FUNCTION refresh_role_assignments();

-- Drop existing problematic policies
DROP POLICY IF EXISTS "View own roles" ON public.user_roles;
DROP POLICY IF EXISTS "Manage roles as admin" ON public.user_roles;

-- Create new simplified policies using materialized view
CREATE POLICY "Users can view own roles"
  ON public.user_roles
  FOR SELECT
  TO authenticated
  USING (
    user_id = auth.uid() OR 
    EXISTS (
      SELECT 1 FROM role_assignments 
      WHERE user_id = auth.uid() 
      AND role_name = 'administrator'
    )
  );

CREATE POLICY "Administrators can manage roles"
  ON public.user_roles
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM role_assignments 
      WHERE user_id = auth.uid() 
      AND role_name = 'administrator'
    )
    AND user_id != auth.uid() -- Prevent modifying own roles
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM role_assignments 
      WHERE user_id = auth.uid() 
      AND role_name = 'administrator'
    )
    AND user_id != auth.uid() -- Prevent modifying own roles
  );

-- Update user_has_role function to use materialized view
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

-- Do initial refresh of role assignments view
REFRESH MATERIALIZED VIEW role_assignments;