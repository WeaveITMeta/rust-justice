/*
  # Connect Court Calendar to Court Locations

  1. Changes
    - Add court_location_id to court_calendars table
    - Add foreign key constraint to court_locations
    - Add index for better performance
    - Update existing policies to include court location filtering

  2. Security
    - Maintain existing RLS policies
    - Add court location-based filtering
*/

-- Add court_location_id to court_calendars
ALTER TABLE public.court_calendars
ADD COLUMN IF NOT EXISTS court_location_id uuid REFERENCES public.court_locations(id);

-- Create index for better performance
CREATE INDEX IF NOT EXISTS idx_court_calendars_location 
ON public.court_calendars(court_location_id);

-- Update policies to include court location filtering
DROP POLICY IF EXISTS "Public can view available calendar events" ON public.court_calendars;
CREATE POLICY "Public can view available calendar events"
  ON public.court_calendars
  FOR SELECT
  TO authenticated
  USING (
    is_available = true AND
    court_location_id IN (
      SELECT id FROM public.court_locations
      WHERE county_id IN (
        SELECT id FROM public.counties
        WHERE state_id IN (
          SELECT id FROM public.states
        )
      )
    )
  );

-- Create function to check appointment availability with court location
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
    AND c.court_location_id IS NOT NULL
  );
END;
$$;