-- Drop existing policies to avoid conflicts
DO $$ 
BEGIN
  DROP POLICY IF EXISTS "Users can view their own settings" ON public.user_settings;
  DROP POLICY IF EXISTS "Users can update their own settings" ON public.user_settings;
  DROP POLICY IF EXISTS "Users can insert their own settings" ON public.user_settings;
END $$;

-- Create comprehensive policies for user_settings
CREATE POLICY "Users can manage their own settings"
  ON public.user_settings
  FOR ALL
  TO authenticated
  USING (id = auth.uid())
  WITH CHECK (id = auth.uid());

-- Create function to initialize user settings
CREATE OR REPLACE FUNCTION initialize_user_settings()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  INSERT INTO public.user_settings (
    id,
    email_notifications,
    sms_notifications,
    language,
    timezone,
    theme,
    accessibility_mode
  ) VALUES (
    NEW.id,
    true,  -- email_notifications default
    false, -- sms_notifications default
    'en',  -- language default
    'UTC', -- timezone default
    'light', -- theme default
    false  -- accessibility_mode default
  );
  RETURN NEW;
END;
$$;

-- Create trigger to automatically create user settings
DROP TRIGGER IF EXISTS create_user_settings ON public.profiles;
CREATE TRIGGER create_user_settings
  AFTER INSERT ON public.profiles
  FOR EACH ROW
  EXECUTE FUNCTION initialize_user_settings();

-- Ensure all existing users have settings
INSERT INTO public.user_settings (
  id,
  email_notifications,
  sms_notifications,
  language,
  timezone,
  theme,
  accessibility_mode
)
SELECT 
  p.id,
  true,  -- email_notifications default
  false, -- sms_notifications default
  'en',  -- language default
  'UTC', -- timezone default
  'light', -- theme default
  false  -- accessibility_mode default
FROM public.profiles p
LEFT JOIN public.user_settings s ON s.id = p.id
WHERE s.id IS NULL;