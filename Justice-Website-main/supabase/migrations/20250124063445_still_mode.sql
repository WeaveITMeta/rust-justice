/*
  # Court Room Calendar Integration

  1. New Tables
    - `court_rooms`
      - Basic room information (name, number, capacity)
      - Google Calendar integration settings
      - Relationship to courts and locations
    
  2. Changes
    - Add Google Calendar fields to `court_calendars`
    - Add court room relationship
    
  3. Security
    - Enable RLS on new tables
    - Add policies for administrators and clerks
*/

-- Create court_rooms table
CREATE TABLE IF NOT EXISTS public.court_rooms (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  location_id uuid REFERENCES public.court_locations(id) ON DELETE CASCADE,
  name text NOT NULL,
  room_number text NOT NULL,
  capacity integer,
  google_calendar_id text,
  google_calendar_integration_enabled boolean DEFAULT false,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(location_id, room_number)
);

-- Add Google Calendar fields to court_calendars
ALTER TABLE public.court_calendars 
ADD COLUMN IF NOT EXISTS court_room_id uuid REFERENCES public.court_rooms(id) ON DELETE CASCADE,
ADD COLUMN IF NOT EXISTS google_calendar_event_id text,
ADD COLUMN IF NOT EXISTS last_synced_at timestamptz;

-- Enable RLS
ALTER TABLE public.court_rooms ENABLE ROW LEVEL SECURITY;

-- Create policies for court_rooms
CREATE POLICY "Allow public read access to court rooms"
  ON public.court_rooms
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Allow admin and clerk management of court rooms"
  ON public.court_rooms
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 
      FROM user_role_cache 
      WHERE user_id = auth.uid() 
      AND role_name IN ('administrator', 'clerk')
    )
  );

-- Create function to sync calendar events
CREATE OR REPLACE FUNCTION sync_google_calendar_event()
RETURNS trigger AS $$
BEGIN
  -- Only update last_synced_at if Google Calendar integration is enabled
  IF EXISTS (
    SELECT 1 
    FROM public.court_rooms cr
    WHERE cr.id = NEW.court_room_id 
    AND cr.google_calendar_integration_enabled = true
  ) THEN
    NEW.last_synced_at = now();
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for calendar sync
CREATE TRIGGER sync_google_calendar_event_trigger
  BEFORE INSERT OR UPDATE ON public.court_calendars
  FOR EACH ROW
  EXECUTE FUNCTION sync_google_calendar_event();

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_court_rooms_location_id ON public.court_rooms(location_id);
CREATE INDEX IF NOT EXISTS idx_court_calendars_room_id ON public.court_calendars(court_room_id);
CREATE INDEX IF NOT EXISTS idx_court_calendars_google_event ON public.court_calendars(google_calendar_event_id);