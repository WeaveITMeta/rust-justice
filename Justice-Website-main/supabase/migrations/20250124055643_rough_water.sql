/*
  # Court Calendar System Schema

  1. New Tables
    - `court_calendars`
      - Stores court calendar events and schedules
      - Includes event details, location, judge, etc.
    
    - `court_appointments`
      - Stores appointment bookings
      - Links to users and calendar events
    
  2. Security
    - Enable RLS on all tables
    - Policies for viewing and managing appointments
    - Separate policies for administrators and regular users

  3. Changes
    - Add calendar management capabilities
    - Support for appointment scheduling
*/

-- Create court_calendars table
CREATE TABLE IF NOT EXISTS public.court_calendars (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text,
  start_time timestamptz NOT NULL,
  end_time timestamptz NOT NULL,
  location text NOT NULL,
  judge_name text,
  event_type text NOT NULL,
  max_appointments integer NOT NULL DEFAULT 1,
  is_available boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  created_by uuid REFERENCES public.profiles(id)
);

-- Create court_appointments table
CREATE TABLE IF NOT EXISTS public.court_appointments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  calendar_id uuid REFERENCES public.court_calendars(id) ON DELETE CASCADE,
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE,
  status text NOT NULL DEFAULT 'pending',
  notes text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(calendar_id, user_id)
);

-- Enable RLS
ALTER TABLE public.court_calendars ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.court_appointments ENABLE ROW LEVEL SECURITY;

-- Policies for court_calendars
CREATE POLICY "Public can view available calendar events"
  ON public.court_calendars
  FOR SELECT
  TO authenticated
  USING (is_available = true);

CREATE POLICY "Administrators can manage calendar events"
  ON public.court_calendars
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.roles r
      JOIN public.user_roles ur ON r.id = ur.role_id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

-- Policies for court_appointments
CREATE POLICY "Users can view their own appointments"
  ON public.court_appointments
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "Users can create their own appointments"
  ON public.court_appointments
  FOR INSERT
  TO authenticated
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own appointments"
  ON public.court_appointments
  FOR UPDATE
  TO authenticated
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Administrators can manage all appointments"
  ON public.court_appointments
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.roles r
      JOIN public.user_roles ur ON r.id = ur.role_id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

-- Create function to check appointment availability
CREATE OR REPLACE FUNCTION check_appointment_availability(calendar_id uuid)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1
    FROM public.court_calendars c
    WHERE c.id = calendar_id
    AND c.is_available = true
    AND (
      SELECT COUNT(*)
      FROM public.court_appointments a
      WHERE a.calendar_id = c.id
    ) < c.max_appointments
  );
END;
$$;