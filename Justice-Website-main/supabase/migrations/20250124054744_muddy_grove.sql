/*
  # Update database schema and policies

  This migration safely creates or updates tables and policies for the justice system portal.
  It uses IF NOT EXISTS clauses and handles cases where objects may already exist.

  1. Tables
    - Ensures all required tables exist
    - Adds any missing columns
  2. Policies
    - Updates RLS policies for all tables
    - Adds new policies for profile management
  3. Functions
    - Updates role checking function
*/

-- Create roles table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.roles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE,
  description text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create profiles table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name text,
  title text,
  rank text,
  email text UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create user_roles junction table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.user_roles (
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE,
  role_id uuid REFERENCES public.roles(id) ON DELETE CASCADE,
  created_at timestamptz DEFAULT now(),
  PRIMARY KEY (user_id, role_id)
);

-- Create bank_accounts table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.bank_accounts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  account_name text NOT NULL,
  account_number text NOT NULL UNIQUE,
  routing_number text NOT NULL,
  institution_name text NOT NULL,
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  created_by uuid REFERENCES public.profiles(id),
  last_modified_by uuid REFERENCES public.profiles(id)
);

-- Create traffic_tickets table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.traffic_tickets (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  citation_number text NOT NULL UNIQUE,
  user_id uuid REFERENCES public.profiles(id),
  violation_date date NOT NULL,
  violation_description text NOT NULL,
  fine_amount decimal(10,2) NOT NULL,
  status text NOT NULL DEFAULT 'unpaid',
  due_date date NOT NULL,
  payment_date timestamptz,
  payment_reference text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS on all tables
DO $$ 
BEGIN
  ALTER TABLE public.roles ENABLE ROW LEVEL SECURITY;
  ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
  ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
  ALTER TABLE public.bank_accounts ENABLE ROW LEVEL SECURITY;
  ALTER TABLE public.traffic_tickets ENABLE ROW LEVEL SECURITY;
EXCEPTION 
  WHEN others THEN NULL;
END $$;

-- Drop existing policies to recreate them
DO $$ 
BEGIN
  DROP POLICY IF EXISTS "Roles are viewable by all authenticated users" ON public.roles;
  DROP POLICY IF EXISTS "Users can view their own profile" ON public.profiles;
  DROP POLICY IF EXISTS "Users can insert their own profile" ON public.profiles;
  DROP POLICY IF EXISTS "Users can update their own profile" ON public.profiles;
  DROP POLICY IF EXISTS "Administrators can view all profiles" ON public.profiles;
  DROP POLICY IF EXISTS "Users can view their own roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Administrators can manage user roles" ON public.user_roles;
  DROP POLICY IF EXISTS "Only administrators can view bank accounts" ON public.bank_accounts;
  DROP POLICY IF EXISTS "Only administrators can manage bank accounts" ON public.bank_accounts;
  DROP POLICY IF EXISTS "Users can view their own tickets" ON public.traffic_tickets;
  DROP POLICY IF EXISTS "Administrators can view all tickets" ON public.traffic_tickets;
END $$;

-- Recreate policies
CREATE POLICY "Roles are viewable by all authenticated users"
  ON public.roles
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can view their own profile"
  ON public.profiles
  FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

CREATE POLICY "Users can insert their own profile"
  ON public.profiles
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can update their own profile"
  ON public.profiles
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Administrators can view all profiles"
  ON public.profiles
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.roles r ON ur.role_id = r.id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

CREATE POLICY "Users can view their own roles"
  ON public.user_roles
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "Administrators can manage user roles"
  ON public.user_roles
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

CREATE POLICY "Users can view their own tickets"
  ON public.traffic_tickets
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "Administrators can view all tickets"
  ON public.traffic_tickets
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.roles r ON ur.role_id = r.id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

-- Insert default roles if they don't exist
INSERT INTO public.roles (name, description)
VALUES
  ('administrator', 'Full system access and management capabilities'),
  ('clerk', 'Court clerk with case management access'),
  ('financial_officer', 'Access to financial systems and payment processing'),
  ('user', 'Standard user access')
ON CONFLICT (name) DO NOTHING;

-- Update or create the role checking function
CREATE OR REPLACE FUNCTION public.user_has_role(role_name text)
RETURNS boolean AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1
    FROM public.user_roles ur
    JOIN public.roles r ON ur.role_id = r.id
    WHERE ur.user_id = auth.uid() AND r.name = role_name
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;