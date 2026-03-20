-- Add court_location_id to traffic_tickets table
ALTER TABLE public.traffic_tickets
ADD COLUMN IF NOT EXISTS court_location_id uuid REFERENCES public.court_locations(id);

-- Create index for better performance
CREATE INDEX IF NOT EXISTS idx_traffic_tickets_court_location 
ON public.traffic_tickets(court_location_id);

-- Update policies to include court location filtering
DROP POLICY IF EXISTS "Users can view their own tickets" ON public.traffic_tickets;
DROP POLICY IF EXISTS "Administrators can view all tickets" ON public.traffic_tickets;

CREATE POLICY "Users can view their own tickets"
  ON public.traffic_tickets
  FOR SELECT
  TO authenticated
  USING (
    user_id = auth.uid() AND
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