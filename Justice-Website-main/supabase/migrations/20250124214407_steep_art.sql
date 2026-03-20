-- First ensure unique indexes exist on materialized views
DROP INDEX IF EXISTS idx_admin_users_user_id;
DROP INDEX IF EXISTS idx_user_role_cache_user_role;
DROP INDEX IF EXISTS idx_active_court_admins_composite;

CREATE UNIQUE INDEX idx_admin_users_user_id ON admin_users(user_id);
CREATE UNIQUE INDEX idx_user_role_cache_user_role ON user_role_cache(user_id, role_name);
CREATE UNIQUE INDEX idx_active_court_admins_composite ON active_court_admins(user_id, court_location_id, role);

-- Add administrator role to mikhailjolson@gmail.com
DO $$
DECLARE
  v_user_id uuid;
  v_admin_role_id uuid;
BEGIN
  -- First create the profile if it doesn't exist
  INSERT INTO public.profiles (
    id,
    email,
    full_name,
    account_status
  )
  VALUES (
    gen_random_uuid(),
    'mikhailjolson@gmail.com',
    'Mikhail Jolson',
    'active'
  )
  ON CONFLICT (email) DO NOTHING
  RETURNING id INTO v_user_id;

  -- If user wasn't just created, get their existing ID
  IF v_user_id IS NULL THEN
    SELECT id INTO v_user_id
    FROM public.profiles
    WHERE email = 'mikhailjolson@gmail.com';
  END IF;

  -- Get administrator role ID
  SELECT id INTO v_admin_role_id
  FROM public.roles
  WHERE name = 'administrator';

  -- Add administrator role to user if not already assigned
  INSERT INTO public.user_roles (user_id, role_id)
  VALUES (v_user_id, v_admin_role_id)
  ON CONFLICT (user_id, role_id) DO NOTHING;

END $$;

-- Refresh materialized views now that indexes exist
REFRESH MATERIALIZED VIEW admin_users;
REFRESH MATERIALIZED VIEW user_role_cache;
REFRESH MATERIALIZED VIEW active_court_admins;