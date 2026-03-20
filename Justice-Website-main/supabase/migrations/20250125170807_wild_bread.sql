-- Create regulation_analysis table
CREATE TABLE IF NOT EXISTS public.regulation_analysis (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  type text NOT NULL CHECK (type IN ('contradiction', 'redundancy', 'constitutional')),
  title text NOT NULL,
  description text NOT NULL,
  citations text[] NOT NULL,
  severity text NOT NULL CHECK (severity IN ('high', 'medium', 'low')),
  recommendation text,
  constitutional_basis text[],
  precedents text[],
  created_at timestamptz DEFAULT now(),
  created_by uuid REFERENCES public.profiles(id),
  is_active boolean DEFAULT true
);

-- Create regulation_tests table
CREATE TABLE IF NOT EXISTS public.regulation_tests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text NOT NULL,
  criteria text[] NOT NULL,
  precedents text[] NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  is_active boolean DEFAULT true
);

-- Enable RLS
ALTER TABLE public.regulation_analysis ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.regulation_tests ENABLE ROW LEVEL SECURITY;

-- Create policies for regulation_analysis
CREATE POLICY "Regulation analysis viewable by authenticated users"
  ON public.regulation_analysis
  FOR SELECT
  TO authenticated
  USING (is_active = true);

CREATE POLICY "Administrators can manage regulation analysis"
  ON public.regulation_analysis
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.roles r ON ur.role_id = r.id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

-- Create policies for regulation_tests
CREATE POLICY "Regulation tests viewable by authenticated users"
  ON public.regulation_tests
  FOR SELECT
  TO authenticated
  USING (is_active = true);

CREATE POLICY "Administrators can manage regulation tests"
  ON public.regulation_tests
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.roles r ON ur.role_id = r.id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

-- Insert default constitutional tests
INSERT INTO public.regulation_tests (name, description, criteria, precedents)
VALUES
  (
    'Rational Basis Test',
    'Evaluates if the law is rationally related to a legitimate government interest',
    ARRAY[
      'Legitimate government purpose',
      'Rational connection between means and ends',
      'Not arbitrary or capricious'
    ],
    ARRAY[
      'United States v. Carolene Products Co., 304 U.S. 144 (1938)',
      'Williamson v. Lee Optical Co., 348 U.S. 483 (1955)'
    ]
  ),
  (
    'Strict Scrutiny Test',
    'Applied to laws affecting fundamental rights or suspect classifications',
    ARRAY[
      'Compelling government interest',
      'Narrowly tailored',
      'Least restrictive means'
    ],
    ARRAY[
      'Loving v. Virginia, 388 U.S. 1 (1967)',
      'Brown v. Board of Education, 347 U.S. 483 (1954)'
    ]
  ),
  (
    'Intermediate Scrutiny Test',
    'Applied to laws affecting quasi-suspect classifications',
    ARRAY[
      'Important government objective',
      'Substantially related means',
      'Exceedingly persuasive justification'
    ],
    ARRAY[
      'Craig v. Boren, 429 U.S. 190 (1976)',
      'United States v. Virginia, 518 U.S. 515 (1996)'
    ]
  )
ON CONFLICT DO NOTHING;