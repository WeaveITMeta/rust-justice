-- Add badge_id to program_tests table
ALTER TABLE public.program_tests
ADD COLUMN IF NOT EXISTS badge_id uuid REFERENCES public.badges(id);

-- Create function to handle test completion and badge assignment
CREATE OR REPLACE FUNCTION handle_test_completion(
  p_user_id uuid,
  p_test_id uuid,
  p_score numeric
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_test program_tests;
  v_badge_awarded boolean := false;
  v_passing_score integer;
  v_badge_id uuid;
BEGIN
  -- Get test details
  SELECT * INTO v_test
  FROM program_tests
  WHERE id = p_test_id;

  -- Check if test exists
  IF NOT FOUND THEN
    RETURN jsonb_build_object(
      'success', false,
      'message', 'Test not found'
    );
  END IF;

  -- Get passing score and badge info
  v_passing_score := v_test.passing_score;
  v_badge_id := v_test.badge_id;

  -- If score meets or exceeds passing score and there's a badge, award it
  IF p_score >= v_passing_score AND v_badge_id IS NOT NULL THEN
    -- Check if user already has this badge
    IF NOT EXISTS (
      SELECT 1 FROM user_badges
      WHERE user_id = p_user_id AND badge_id = v_badge_id
    ) THEN
      -- Award the badge
      INSERT INTO user_badges (
        user_id,
        badge_id,
        program_id,
        awarded_at
      ) VALUES (
        p_user_id,
        v_badge_id,
        v_test.program_id,
        now()
      );
      v_badge_awarded := true;
    END IF;
  END IF;

  -- Return result
  RETURN jsonb_build_object(
    'success', true,
    'passed', p_score >= v_passing_score,
    'badge_awarded', v_badge_awarded,
    'passing_score', v_passing_score
  );
END;
$$;

-- Create function to check test completion status
CREATE OR REPLACE FUNCTION get_test_completion_status(
  p_user_id uuid,
  p_test_id uuid
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_test program_tests;
  v_best_score numeric;
  v_attempts integer;
  v_has_badge boolean;
BEGIN
  -- Get test details
  SELECT * INTO v_test
  FROM program_tests
  WHERE id = p_test_id;

  -- Get user's best score and attempt count
  SELECT 
    MAX(score),
    COUNT(*)
  INTO v_best_score, v_attempts
  FROM user_test_results
  WHERE user_id = p_user_id AND test_id = p_test_id;

  -- Check if user has the badge
  SELECT EXISTS (
    SELECT 1 
    FROM user_badges
    WHERE user_id = p_user_id 
    AND badge_id = v_test.badge_id
  ) INTO v_has_badge;

  -- Return status
  RETURN jsonb_build_object(
    'best_score', v_best_score,
    'attempts', v_attempts,
    'passing_score', v_test.passing_score,
    'has_passed', COALESCE(v_best_score >= v_test.passing_score, false),
    'has_badge', v_has_badge
  );
END;
$$;

-- Update the calculate_test_score function to handle badge assignment
CREATE OR REPLACE FUNCTION calculate_test_score(
  p_test_id uuid,
  p_answers jsonb,
  p_user_id uuid
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_total_points integer;
  v_earned_points integer := 0;
  v_question record;
  v_score numeric;
  v_completion_result jsonb;
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

  -- Calculate percentage score
  v_score := ROUND((v_earned_points::numeric / v_total_points::numeric) * 100, 2);

  -- Handle test completion and badge assignment
  v_completion_result := handle_test_completion(p_user_id, p_test_id, v_score);

  -- Return combined results
  RETURN jsonb_build_object(
    'score', v_score,
    'earned_points', v_earned_points,
    'total_points', v_total_points,
    'completion_status', v_completion_result
  );
END;
$$;

-- Create index for badge lookups
CREATE INDEX IF NOT EXISTS idx_program_tests_badge ON program_tests(badge_id);