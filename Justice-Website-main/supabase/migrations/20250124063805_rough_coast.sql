/*
  # Enhance User Profile System

  1. Profile Enhancements
    - Add additional user profile fields
    - Add account security features
    - Add user preferences and settings
    - Add session tracking

  2. Security
    - Add RLS policies for user settings and sessions
    - Add functions for login attempt tracking
    - Add session management
*/

-- Enhance profiles table
DO $$ 
BEGIN
  ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS phone text,
  ADD COLUMN IF NOT EXISTS date_of_birth date,
  ADD COLUMN IF NOT EXISTS address text,
  ADD COLUMN IF NOT EXISTS city text,
  ADD COLUMN IF NOT EXISTS state text,
  ADD COLUMN IF NOT EXISTS zip_code text,
  ADD COLUMN IF NOT EXISTS account_status text DEFAULT 'active',
  ADD COLUMN IF NOT EXISTS two_factor_enabled boolean DEFAULT false,
  ADD COLUMN IF NOT EXISTS last_login timestamptz,
  ADD COLUMN IF NOT EXISTS failed_login_attempts integer DEFAULT 0,
  ADD COLUMN IF NOT EXISTS password_last_changed timestamptz;
END $$;

-- Create user_settings table
CREATE TABLE IF NOT EXISTS public.user_settings (
  id uuid PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  email_notifications boolean DEFAULT true,
  sms_notifications boolean DEFAULT false,
  language text DEFAULT 'en',
  timezone text DEFAULT 'UTC',
  theme text DEFAULT 'light',
  accessibility_mode boolean DEFAULT false,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create user_sessions table
CREATE TABLE IF NOT EXISTS public.user_sessions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE,
  device_type text,
  browser text,
  ip_address text,
  location text,
  started_at timestamptz DEFAULT now(),
  last_active_at timestamptz DEFAULT now(),
  ended_at timestamptz,
  is_active boolean DEFAULT true
);

-- Enable RLS
ALTER TABLE public.user_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_sessions ENABLE ROW LEVEL SECURITY;

-- Drop existing policies to avoid conflicts
DO $$ 
BEGIN
  DROP POLICY IF EXISTS "Users can view their own settings" ON public.user_settings;
  DROP POLICY IF EXISTS "Users can update their own settings" ON public.user_settings;
  DROP POLICY IF EXISTS "Users can view their own sessions" ON public.user_sessions;
END $$;

-- Create policies for user_settings
DO $$ 
BEGIN
  CREATE POLICY "Users can view their own settings"
    ON public.user_settings
    FOR SELECT
    TO authenticated
    USING (id = auth.uid());

  CREATE POLICY "Users can update their own settings"
    ON public.user_settings
    FOR UPDATE
    TO authenticated
    USING (id = auth.uid())
    WITH CHECK (id = auth.uid());

  CREATE POLICY "Users can view their own sessions"
    ON public.user_sessions
    FOR SELECT
    TO authenticated
    USING (user_id = auth.uid());
END $$;

-- Drop existing functions and triggers to avoid conflicts
DO $$ 
BEGIN
  DROP TRIGGER IF EXISTS update_last_activity_trigger ON public.user_sessions;
  DROP FUNCTION IF EXISTS update_last_activity();
  DROP FUNCTION IF EXISTS handle_failed_login(uuid);
  DROP FUNCTION IF EXISTS reset_failed_login_attempts(uuid);
END $$;

-- Create function to update last activity
CREATE OR REPLACE FUNCTION update_last_activity()
RETURNS trigger AS $$
BEGIN
  UPDATE public.profiles
  SET last_login = now()
  WHERE id = NEW.user_id;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for last activity
CREATE TRIGGER update_last_activity_trigger
  AFTER INSERT ON public.user_sessions
  FOR EACH ROW
  EXECUTE FUNCTION update_last_activity();

-- Create function to handle failed login attempts
CREATE OR REPLACE FUNCTION handle_failed_login(user_id uuid)
RETURNS void AS $$
BEGIN
  UPDATE public.profiles
  SET 
    failed_login_attempts = failed_login_attempts + 1,
    account_status = CASE 
      WHEN failed_login_attempts >= 5 THEN 'locked'
      ELSE account_status
    END
  WHERE id = user_id;
END;
$$ LANGUAGE plpgsql;

-- Create function to reset failed login attempts
CREATE OR REPLACE FUNCTION reset_failed_login_attempts(user_id uuid)
RETURNS void AS $$
BEGIN
  UPDATE public.profiles
  SET 
    failed_login_attempts = 0,
    account_status = 'active'
  WHERE id = user_id;
END;
$$ LANGUAGE plpgsql;