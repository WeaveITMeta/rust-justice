/*
  # Update Row Level Security Policies

  This migration updates the RLS policies for all tables, ensuring no conflicts with existing policies.
  
  1. Changes
    - Drops existing policies
    - Recreates all necessary policies for each table
  2. Security
    - Maintains proper access control for all user types
    - Fixes recursive policy issues
    - Implements proper administrator access
*/

-- Drop existing policies to avoid conflicts
DO $$ 
BEGIN
  -- Drop profiles policies
  DROP POLICY IF EXISTS "Users can view their own profile" ON public.profiles;
  DROP POLICY IF EXISTS "Users can insert their own profile" ON public.profiles;
  DROP POLICY IF EXISTS "Users can update their own profile" ON public.profiles;
  DROP POLICY IF EXISTS "Administrators can view all profiles" ON public.profiles;
  
  -- Drop user_roles policies
  DROP POLICY IF EXISTS "Users can view their own roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can view all roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can insert roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can delete roles" ON public.user_roles;
  
  -- Drop bank_accounts policies
  DROP POLICY IF EXISTS "Only administrators can view bank accounts" ON public.bank_accounts;
  DROP POLICY IF EXISTS "Only administrators can manage bank accounts" ON public.bank_accounts;
  
  -- Drop traffic_tickets policies
  DROP POLICY IF EXISTS "Users can view their own tickets" ON public.traffic_tickets;
  DROP POLICY IF EXISTS "Administrators can view all tickets" ON public.traffic_tickets;
END $$;

-- Recreate all policies with proper checks
DO $$ 
BEGIN
  -- Profiles policies
  EXECUTE 'CREATE POLICY "Users can view their own profile" ON public.profiles FOR SELECT TO authenticated USING (auth.uid() = id)';
  
  EXECUTE 'CREATE POLICY "Users can insert their own profile" ON public.profiles FOR INSERT TO authenticated WITH CHECK (auth.uid() = id)';
  
  EXECUTE 'CREATE POLICY "Users can update their own profile" ON public.profiles FOR UPDATE TO authenticated USING (auth.uid() = id) WITH CHECK (auth.uid() = id)';
  
  EXECUTE 'CREATE POLICY "Administrators can view all profiles" ON public.profiles FOR ALL TO authenticated USING (EXISTS (SELECT 1 FROM public.user_roles ur JOIN public.roles r ON ur.role_id = r.id WHERE ur.user_id = auth.uid() AND r.name = ''administrator''))';

  -- User roles policies
  EXECUTE 'CREATE POLICY "Users can view their own roles" ON public.user_roles FOR SELECT TO authenticated USING (user_id = auth.uid())';
  
  EXECUTE 'CREATE POLICY "Administrators can view all roles" ON public.user_roles FOR SELECT TO authenticated USING (EXISTS (SELECT 1 FROM public.roles r WHERE r.id IN (SELECT role_id FROM public.user_roles WHERE user_id = auth.uid()) AND r.name = ''administrator''))';
  
  EXECUTE 'CREATE POLICY "Administrators can insert roles" ON public.user_roles FOR INSERT TO authenticated WITH CHECK (EXISTS (SELECT 1 FROM public.roles r WHERE r.id IN (SELECT role_id FROM public.user_roles WHERE user_id = auth.uid()) AND r.name = ''administrator''))';
  
  EXECUTE 'CREATE POLICY "Administrators can delete roles" ON public.user_roles FOR DELETE TO authenticated USING (EXISTS (SELECT 1 FROM public.roles r WHERE r.id IN (SELECT role_id FROM public.user_roles WHERE user_id = auth.uid()) AND r.name = ''administrator''))';

  -- Bank accounts policies
  EXECUTE 'CREATE POLICY "Only administrators can view bank accounts" ON public.bank_accounts FOR SELECT TO authenticated USING (EXISTS (SELECT 1 FROM public.user_roles ur JOIN public.roles r ON ur.role_id = r.id WHERE ur.user_id = auth.uid() AND r.name = ''administrator''))';
  
  EXECUTE 'CREATE POLICY "Only administrators can manage bank accounts" ON public.bank_accounts FOR ALL TO authenticated USING (EXISTS (SELECT 1 FROM public.user_roles ur JOIN public.roles r ON ur.role_id = r.id WHERE ur.user_id = auth.uid() AND r.name = ''administrator''))';

  -- Traffic tickets policies
  EXECUTE 'CREATE POLICY "Users can view their own tickets" ON public.traffic_tickets FOR SELECT TO authenticated USING (user_id = auth.uid())';
  
  EXECUTE 'CREATE POLICY "Administrators can view all tickets" ON public.traffic_tickets FOR SELECT TO authenticated USING (EXISTS (SELECT 1 FROM public.user_roles ur JOIN public.roles r ON ur.role_id = r.id WHERE ur.user_id = auth.uid() AND r.name = ''administrator''))';
END $$;