-- Create programs table
CREATE TABLE IF NOT EXISTS public.programs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text,
  requirements text[],
  steps text[],
  completion_criteria text[],
  badge_id uuid,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  created_by uuid REFERENCES public.profiles(id),
  is_active boolean DEFAULT true
);

-- Create badges table
CREATE TABLE IF NOT EXISTS public.badges (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  icon_url text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  created_by uuid REFERENCES public.profiles(id)
);

-- Create user_badges table for badge assignments
CREATE TABLE IF NOT EXISTS public.user_badges (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE,
  badge_id uuid REFERENCES public.badges(id) ON DELETE CASCADE,
  program_id uuid REFERENCES public.programs(id) ON DELETE CASCADE,
  awarded_at timestamptz DEFAULT now(),
  awarded_by uuid REFERENCES public.profiles(id),
  UNIQUE(user_id, badge_id)
);

-- Create user_program_progress table
CREATE TABLE IF NOT EXISTS public.user_program_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE,
  program_id uuid REFERENCES public.programs(id) ON DELETE CASCADE,
  completed_steps text[],
  started_at timestamptz DEFAULT now(),
  completed_at timestamptz,
  status text DEFAULT 'in_progress',
  UNIQUE(user_id, program_id)
);

-- Enable RLS
ALTER TABLE public.programs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.badges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_badges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_program_progress ENABLE ROW LEVEL SECURITY;

-- Create policies for programs
CREATE POLICY "Programs are viewable by all authenticated users"
  ON public.programs
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Administrators can manage programs"
  ON public.programs
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.roles r ON ur.role_id = r.id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

-- Create policies for badges
CREATE POLICY "Badges are viewable by all authenticated users"
  ON public.badges
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Administrators can manage badges"
  ON public.badges
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.roles r ON ur.role_id = r.id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

-- Create policies for user_badges
CREATE POLICY "Users can view their own badges"
  ON public.user_badges
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "Administrators can manage user badges"
  ON public.user_badges
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.roles r ON ur.role_id = r.id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

-- Create policies for user_program_progress
CREATE POLICY "Users can view and update their own progress"
  ON public.user_program_progress
  FOR ALL
  TO authenticated
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Administrators can view all progress"
  ON public.user_program_progress
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.roles r ON ur.role_id = r.id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

-- Create function to award badge
CREATE OR REPLACE FUNCTION award_badge(
  p_user_id uuid,
  p_badge_id uuid,
  p_program_id uuid
)
RETURNS uuid
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_user_badge_id uuid;
BEGIN
  -- Check if user has already earned this badge
  IF EXISTS (
    SELECT 1 FROM public.user_badges
    WHERE user_id = p_user_id AND badge_id = p_badge_id
  ) THEN
    RETURN NULL;
  END IF;

  -- Award the badge
  INSERT INTO public.user_badges (
    user_id,
    badge_id,
    program_id,
    awarded_by
  )
  VALUES (
    p_user_id,
    p_badge_id,
    p_program_id,
    auth.uid()
  )
  RETURNING id INTO v_user_badge_id;

  RETURN v_user_badge_id;
END;
$$;

-- Create function to check program completion
CREATE OR REPLACE FUNCTION check_program_completion(
  p_user_id uuid,
  p_program_id uuid
)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_program programs;
  v_progress user_program_progress;
BEGIN
  -- Get program details
  SELECT * INTO v_program
  FROM programs
  WHERE id = p_program_id;

  -- Get user progress
  SELECT * INTO v_progress
  FROM user_program_progress
  WHERE user_id = p_user_id AND program_id = p_program_id;

  -- Check if all steps are completed
  IF v_progress.completed_steps IS NULL OR 
     array_length(v_progress.completed_steps, 1) < array_length(v_program.steps, 1) THEN
    RETURN false;
  END IF;

  -- If all steps completed, award badge and mark as complete
  UPDATE user_program_progress
  SET 
    status = 'completed',
    completed_at = now()
  WHERE id = v_progress.id;

  -- Award badge if program has one
  IF v_program.badge_id IS NOT NULL THEN
    PERFORM award_badge(p_user_id, v_program.badge_id, p_program_id);
  END IF;

  RETURN true;
END;
$$;