/*
  # Court Locations Schema

  1. New Tables
    - `states`
      - `id` (uuid, primary key)
      - `name` (text, state name)
      - `code` (text, 2-letter state code)
      - `created_at` (timestamp)
    
    - `counties`
      - `id` (uuid, primary key)
      - `state_id` (uuid, foreign key to states)
      - `name` (text, county name)
      - `created_at` (timestamp)
    
    - `court_locations`
      - `id` (uuid, primary key)
      - `county_id` (uuid, foreign key to counties)
      - `name` (text, court name)
      - `address` (text)
      - `city` (text)
      - `zip_code` (text)
      - `phone` (text)
      - `hours` (text)
      - `website` (text)
      - `latitude` (numeric)
      - `longitude` (numeric)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for public read access
*/

-- Create states table
CREATE TABLE IF NOT EXISTS public.states (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE,
  code text NOT NULL UNIQUE,
  created_at timestamptz DEFAULT now()
);

-- Create counties table
CREATE TABLE IF NOT EXISTS public.counties (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  state_id uuid REFERENCES public.states(id) ON DELETE CASCADE,
  name text NOT NULL,
  created_at timestamptz DEFAULT now(),
  UNIQUE(state_id, name)
);

-- Create court_locations table
CREATE TABLE IF NOT EXISTS public.court_locations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  county_id uuid REFERENCES public.counties(id) ON DELETE CASCADE,
  name text NOT NULL,
  address text NOT NULL,
  city text NOT NULL,
  zip_code text NOT NULL,
  phone text,
  hours text,
  website text,
  latitude numeric(10,6),
  longitude numeric(10,6),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE public.states ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.counties ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.court_locations ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access
CREATE POLICY "Allow public read access to states"
  ON public.states
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Allow public read access to counties"
  ON public.counties
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Allow public read access to court locations"
  ON public.court_locations
  FOR SELECT
  TO authenticated
  USING (true);

-- Create admin policies for management
CREATE POLICY "Allow admin management of states"
  ON public.states
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.roles r ON ur.role_id = r.id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

CREATE POLICY "Allow admin management of counties"
  ON public.counties
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