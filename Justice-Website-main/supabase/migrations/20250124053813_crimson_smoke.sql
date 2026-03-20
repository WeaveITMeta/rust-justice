/*
  # User Management and Roles System

  1. New Tables
    - `profiles`
      - Extends auth.users with additional user information
      - Stores rank and title information
      - Links to auth.users via user_id
    
    - `roles`
      - Defines system roles and their permissions
      - Stores role name and description
    
    - `user_roles`
      - Junction table linking users to roles
      - Allows users to have multiple roles
    
    - `bank_accounts`
      - Stores court system bank accounts
      - Only accessible by authorized administrators
    
    - `traffic_tickets`
      - Stores traffic violation tickets
      - Links to users who received the ticket
      - Tracks payment status

  2. Security
    - Enable RLS on all tables
    - Add policies for role-based access
    - Ensure bank account access is restricted to admin roles
*/

-- Create roles table
CREATE TABLE public.roles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE,
  description text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create profiles table extending auth.users
CREATE TABLE public.profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name text,
  title text,
  rank text,
  email text UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create user_roles junction table
CREATE TABLE public.user_roles (
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE,
  role_id uuid REFERENCES public.roles(id) ON DELETE CASCADE,
  created_at timestamptz DEFAULT now(),
  PRIMARY KEY (user_id, role_id)
);

-- Create bank_accounts table
CREATE TABLE public.bank_accounts (
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

-- Create traffic_tickets table
CREATE TABLE public.traffic_tickets (
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
ALTER TABLE public.roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bank_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.traffic_tickets ENABLE ROW LEVEL SECURITY;

-- Create policies for roles table
CREATE POLICY "Roles are viewable by all authenticated users"
  ON public.roles
  FOR SELECT
  TO authenticated
  USING (true);

-- Create policies for profiles table
CREATE POLICY "Users can view their own profile"
  ON public.profiles
  FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

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

-- Create policies for user_roles table
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

-- Create policies for bank_accounts table
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

-- Create policies for traffic_tickets table
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

-- Insert default roles
INSERT INTO public.roles (name, description) VALUES
  ('administrator', 'Full system access and management capabilities'),
  ('clerk', 'Court clerk with case management access'),
  ('financial_officer', 'Access to financial systems and payment processing'),
  ('user', 'Standard user access');

-- Create function to check if user has role
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