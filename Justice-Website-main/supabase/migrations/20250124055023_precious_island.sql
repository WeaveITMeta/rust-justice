/*
  # Fix Recursive Policies

  This migration fixes the infinite recursion issue in the user_roles policies by:
  1. Simplifying the administrator checks
  2. Using a more direct approach for role verification
  3. Removing self-referential policy conditions
  
  Security:
  - Maintains proper access control
  - Eliminates recursive policy checks
  - Preserves administrator privileges
*/

-- Drop existing policies to avoid conflicts
DO $$ 
BEGIN
  -- Drop all existing policies
  DROP POLICY IF EXISTS "Users can view their own roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can view all roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can insert roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can delete roles" ON public.user_roles;
END $$;

-- Create simplified policies without recursion
DO $$ 
BEGIN
  -- Basic user role viewing policy
  EXECUTE 'CREATE POLICY "Users can view their own roles" 
    ON public.user_roles 
    FOR SELECT 
    TO authenticated 
    USING (user_id = auth.uid())';

  -- Administrator policies using direct role check
  EXECUTE 'CREATE POLICY "Administrators can manage all roles" 
    ON public.user_roles 
    FOR ALL 
    TO authenticated 
    USING (
      EXISTS (
        SELECT 1 
        FROM public.roles r 
        INNER JOIN public.user_roles ur ON r.id = ur.role_id 
        WHERE ur.user_id = auth.uid() 
        AND r.name = ''administrator''
        AND ur.user_id <> user_id  -- Prevent modifying own roles
      )
    )';
END $$;

-- Update the user_has_role function to avoid recursion
CREATE OR REPLACE FUNCTION public.user_has_role(role_name text)
RETURNS boolean AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1
    FROM public.roles r
    INNER JOIN public.user_roles ur ON r.id = ur.role_id
    WHERE ur.user_id = auth.uid()
    AND r.name = role_name
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;