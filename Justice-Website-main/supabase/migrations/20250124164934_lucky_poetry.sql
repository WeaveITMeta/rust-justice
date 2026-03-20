/*
  # Add LinkedIn and Twitter OAuth Support

  1. New Columns
    - Add LinkedIn and Twitter specific fields to profiles table
    - Add provider-specific metadata storage

  2. Security
    - Add RLS policies for OAuth data
    - Add functions for provider linking/unlinking
*/

-- Add LinkedIn and Twitter specific fields to profiles
ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS linkedin_profile_url text,
ADD COLUMN IF NOT EXISTS twitter_username text,
ADD COLUMN IF NOT EXISTS twitter_verified boolean DEFAULT false;

-- Create function to link LinkedIn account
CREATE OR REPLACE FUNCTION link_linkedin_account(
  provider_id text,
  profile_url text
)
RETURNS void
LANGUAGE sql
SECURITY DEFINER
AS $$
  UPDATE public.profiles
  SET 
    oauth_providers = oauth_providers || 
      jsonb_build_object('linkedin', jsonb_build_object(
        'id', provider_id,
        'profile_url', profile_url,
        'linked_at', extract(epoch from now())
      )),
    linkedin_profile_url = profile_url,
    oauth_id = CASE 
      WHEN oauth_id IS NULL THEN provider_id
      ELSE oauth_id
    END
  WHERE id = auth.uid();
$$;

-- Create function to link Twitter/X account
CREATE OR REPLACE FUNCTION link_twitter_account(
  provider_id text,
  username text,
  verified boolean
)
RETURNS void
LANGUAGE sql
SECURITY DEFINER
AS $$
  UPDATE public.profiles
  SET 
    oauth_providers = oauth_providers || 
      jsonb_build_object('twitter', jsonb_build_object(
        'id', provider_id,
        'username', username,
        'verified', verified,
        'linked_at', extract(epoch from now())
      )),
    twitter_username = username,
    twitter_verified = verified,
    oauth_id = CASE 
      WHEN oauth_id IS NULL THEN provider_id
      ELSE oauth_id
    END
  WHERE id = auth.uid();
$$;

-- Create function to unlink OAuth provider
CREATE OR REPLACE FUNCTION unlink_oauth_provider(
  provider text
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Remove provider from oauth_providers
  UPDATE public.profiles
  SET oauth_providers = oauth_providers - provider
  WHERE id = auth.uid();

  -- Reset provider-specific fields
  CASE provider
    WHEN 'linkedin' THEN
      UPDATE public.profiles
      SET linkedin_profile_url = NULL
      WHERE id = auth.uid();
    WHEN 'twitter' THEN
      UPDATE public.profiles
      SET 
        twitter_username = NULL,
        twitter_verified = false
      WHERE id = auth.uid();
    ELSE
      NULL;
  END CASE;
END;
$$;

-- Create function to check if user has linked a specific provider
CREATE OR REPLACE FUNCTION has_oauth_provider(
  provider text
)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT 
    CASE 
      WHEN provider = ANY(ARRAY['linkedin', 'twitter']) THEN
        EXISTS (
          SELECT 1
          FROM public.profiles
          WHERE id = auth.uid()
          AND oauth_providers ? provider
        )
      ELSE false
    END;
$$;

-- Create indexes for OAuth provider lookups
CREATE INDEX IF NOT EXISTS idx_profiles_linkedin_url ON profiles(linkedin_profile_url)
WHERE linkedin_profile_url IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_profiles_twitter_username ON profiles(twitter_username)
WHERE twitter_username IS NOT NULL;

-- Add RLS policies for OAuth data
CREATE POLICY "Users can view their own OAuth data"
  ON public.profiles
  FOR SELECT
  TO authenticated
  USING (
    id = auth.uid() OR
    EXISTS (
      SELECT 1 
      FROM public.court_administrators ca
      WHERE ca.user_id = auth.uid()
      AND ca.role IN ('chief_judge', 'judge')
      AND ca.is_active = true
      AND ca.revoked_at IS NULL
    )
  );