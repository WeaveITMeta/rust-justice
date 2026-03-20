-- Drop existing problematic policies
DROP POLICY IF EXISTS "Users can view their own roles" ON public.court_administrators;
DROP POLICY IF EXISTS "Admins can view roles for their court" ON public.court_administrators;

-- Create simplified policies without recursion
CREATE POLICY "View own court roles"
  ON public.court_administrators
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "View court roles as admin"
  ON public.court_administrators
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 
      FROM active_court_admins
      WHERE user_id = auth.uid()
      AND role IN ('chief_judge', 'judge', 'administrator')
    )
  );

-- Create function to check admin status without recursion
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

-- Refresh materialized view to ensure it's up to date
REFRESH MATERIALIZED VIEW CONCURRENTLY active_court_admins;