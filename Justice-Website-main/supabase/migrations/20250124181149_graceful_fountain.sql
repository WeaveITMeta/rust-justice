-- Create program_tests table
CREATE TABLE IF NOT EXISTS public.program_tests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  program_id uuid REFERENCES public.programs(id) ON DELETE CASCADE,
  title text NOT NULL,
  description text,
  passing_score integer NOT NULL DEFAULT 70,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  created_by uuid REFERENCES public.profiles(id),
  is_active boolean DEFAULT true
);

-- Create test_questions table
CREATE TABLE IF NOT EXISTS public.test_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  test_id uuid REFERENCES public.program_tests(id) ON DELETE CASCADE,
  question text NOT NULL,
  options jsonb NOT NULL, -- Array of possible answers
  correct_answer text NOT NULL,
  explanation text,
  points integer DEFAULT 1,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  order_number integer NOT NULL
);

-- Create user_test_results table
CREATE TABLE IF NOT EXISTS public.user_test_results (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE,
  test_id uuid REFERENCES public.program_tests(id) ON DELETE CASCADE,
  score numeric(5,2) NOT NULL, -- Percentage score (e.g., 85.50)
  correct_answers integer NOT NULL,
  total_questions integer NOT NULL,
  answers jsonb NOT NULL, -- Record of user's answers
  completed_at timestamptz DEFAULT now(),
  UNIQUE(user_id, test_id, completed_at)
);

-- Enable RLS
ALTER TABLE public.program_tests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.test_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_test_results ENABLE ROW LEVEL SECURITY;

-- Create policies for program_tests
CREATE POLICY "Program tests are viewable by all authenticated users"
  ON public.program_tests
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Administrators can manage program tests"
  ON public.program_tests
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.roles r ON ur.role_id = r.id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

-- Create policies for test_questions
CREATE POLICY "Test questions are viewable by all authenticated users"
  ON public.test_questions
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Administrators can manage test questions"
  ON public.test_questions
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.roles r ON ur.role_id = r.id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

-- Create policies for user_test_results
CREATE POLICY "Users can view their own test results"
  ON public.user_test_results
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert their own test results"
  ON public.user_test_results
  FOR INSERT
  TO authenticated
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Administrators can view all test results"
  ON public.user_test_results
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.roles r ON ur.role_id = r.id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_program_tests_program ON program_tests(program_id);
CREATE INDEX IF NOT EXISTS idx_test_questions_test ON test_questions(test_id);
CREATE INDEX IF NOT EXISTS idx_test_questions_order ON test_questions(test_id, order_number);
CREATE INDEX IF NOT EXISTS idx_user_test_results_user ON user_test_results(user_id);
CREATE INDEX IF NOT EXISTS idx_user_test_results_test ON user_test_results(test_id);
CREATE INDEX IF NOT EXISTS idx_user_test_results_score ON user_test_results(test_id, score);

-- Create function to calculate test score
CREATE OR REPLACE FUNCTION calculate_test_score(
  p_test_id uuid,
  p_answers jsonb
)
RETURNS numeric
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_total_points integer;
  v_earned_points integer := 0;
  v_question record;
BEGIN
  -- Get total possible points
  SELECT SUM(points) INTO v_total_points
  FROM test_questions
  WHERE test_id = p_test_id;

  -- Calculate earned points
  FOR v_question IN
    SELECT id, correct_answer, points
    FROM test_questions
    WHERE test_id = p_test_id
  LOOP
    IF p_answers->v_question.id::text = v_question.correct_answer::jsonb THEN
      v_earned_points := v_earned_points + v_question.points;
    END IF;
  END LOOP;

  -- Return percentage score
  RETURN ROUND((v_earned_points::numeric / v_total_points::numeric) * 100, 2);
END;
$$;

-- Create function to check if user passed test
CREATE OR REPLACE FUNCTION has_passed_test(
  p_user_id uuid,
  p_test_id uuid
)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_passing_score integer;
  v_best_score numeric;
BEGIN
  -- Get passing score for test
  SELECT passing_score INTO v_passing_score
  FROM program_tests
  WHERE id = p_test_id;

  -- Get user's best score
  SELECT MAX(score) INTO v_best_score
  FROM user_test_results
  WHERE user_id = p_user_id AND test_id = p_test_id;

  RETURN v_best_score >= v_passing_score;
END;
$$;

-- Create function to get test statistics
CREATE OR REPLACE FUNCTION get_test_statistics(
  p_test_id uuid
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_stats jsonb;
BEGIN
  SELECT jsonb_build_object(
    'total_attempts', COUNT(*),
    'avg_score', ROUND(AVG(score), 2),
    'passing_rate', ROUND((COUNT(*) FILTER (WHERE score >= pt.passing_score)::numeric / COUNT(*)::numeric) * 100, 2),
    'high_score', MAX(score),
    'low_score', MIN(score)
  ) INTO v_stats
  FROM user_test_results utr
  JOIN program_tests pt ON pt.id = utr.test_id
  WHERE test_id = p_test_id;

  RETURN v_stats;
END;
$$;