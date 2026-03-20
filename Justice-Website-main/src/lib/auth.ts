import { createClient } from '@supabase/supabase-js';
import { Database } from './database.types';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables');
}

export const supabase = createClient<Database>(supabaseUrl, supabaseAnonKey, {
  auth: {
    persistSession: true,
    autoRefreshToken: true,
    detectSessionInUrl: true,
    storage: window.localStorage
  }
});

export interface UserProfile {
  id: string;
  full_name: string | null;
  email: string;
  phone: string | null;
  date_of_birth: string | null;
  address: string | null;
  city: string | null;
  state: string | null;
  zip_code: string | null;
  title: string | null;
  rank: string | null;
  roles: string[];
  account_status: string;
  two_factor_enabled: boolean;
  last_login: string | null;
}

export async function signUp(email: string, password: string, fullName: string) {
  const { data: authData, error: authError } = await supabase.auth.signUp({
    email,
    password,
    options: {
      data: {
        full_name: fullName
      }
    }
  });

  if (authError) throw authError;

  if (authData.user) {
    const { error: profileError } = await supabase
      .from('profiles')
      .insert([
        {
          id: authData.user.id,
          full_name: fullName,
          email: email,
          account_status: 'active',
        },
      ]);

    if (profileError) throw profileError;

    // Create default user settings
    const { error: settingsError } = await supabase
      .from('user_settings')
      .insert([{ id: authData.user.id }]);

    if (settingsError) throw settingsError;

    // Assign default user role
    const { data: roleData, error: roleError } = await supabase
      .from('roles')
      .select('id')
      .eq('name', 'user')
      .single();

    if (roleError) throw roleError;

    const { error: userRoleError } = await supabase
      .from('user_roles')
      .insert([
        {
          user_id: authData.user.id,
          role_id: roleData.id,
        },
      ]);

    if (userRoleError) throw userRoleError;
  }

  return authData;
}

export async function signIn(email: string, password: string) {
  try {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });

    if (error) throw error;

    if (data.user) {
      // Reset failed login attempts
      await supabase.rpc('reset_failed_login_attempts', {
        user_id: data.user.id
      });

      // Create session record
      const sessionInfo = await getSessionInfo();
      await supabase
        .from('user_sessions')
        .insert([{
          user_id: data.user.id,
          ...sessionInfo
        }]);
    }

    return data;
  } catch (error) {
    // Handle failed login attempt
    const { data: userData } = await supabase
      .from('profiles')
      .select('id')
      .eq('email', email)
      .single();

    if (userData) {
      await supabase.rpc('handle_failed_login', {
        user_id: userData.id
      });
    }

    throw error;
  }
}

export async function signOut() {
  // End current session
  const { data: { session } } = await supabase.auth.getSession();
  if (session) {
    await supabase
      .from('user_sessions')
      .update({ 
        is_active: false,
        ended_at: new Date().toISOString()
      })
      .eq('user_id', session.user.id)
      .is('ended_at', null);
  }

  const { error } = await supabase.auth.signOut();
  if (error) throw error;
}

export async function resetPassword(email: string) {
  const { error } = await supabase.auth.resetPasswordForEmail(email, {
    redirectTo: `${window.location.origin}/reset-password`,
  });
  if (error) throw error;
}

export async function updatePassword(newPassword: string) {
  const { error } = await supabase.auth.updateUser({
    password: newPassword
  });
  if (error) throw error;
}

export async function getCurrentUser(): Promise<UserProfile | null> {
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) return null;

  const { data: profile, error: profileError } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', user.id)
    .maybeSingle();

  if (profileError) throw profileError;
  if (!profile) return null;

  const { data: roles, error: rolesError } = await supabase
    .from('user_roles')
    .select('roles(name)')
    .eq('user_id', user.id);

  if (rolesError) throw rolesError;

  return {
    ...profile,
    roles: roles?.map(r => r.roles.name) || [],
  };
}

export async function hasRole(roleName: string): Promise<boolean> {
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return false;

  const { data, error } = await supabase.rpc('user_has_role', {
    role_name: roleName
  });

  if (error) throw error;
  return data;
}

export async function getUserSettings() {
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) return null;

  const { data, error } = await supabase
    .from('user_settings')
    .select('*')
    .eq('id', user.id)
    .single();

  if (error) throw error;
  return data;
}

export async function updateUserSettings(settings: Partial<UserSettings>) {
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) throw new Error('Not authenticated');

  const { error } = await supabase
    .from('user_settings')
    .update(settings)
    .eq('id', user.id);

  if (error) throw error;
}

export async function getUserRoleByEmail(email: string): Promise<string[]> {
  const { data, error } = await supabase
    .from('profiles')
    .select(`
      id,
      user_roles (
        roles (
          name
        )
      )
    `)
    .eq('email', email)
    .single();

  if (error) throw error;
  if (!data) return [];

  return data.user_roles?.map(ur => ur.roles.name) || [];
}

async function getSessionInfo(): Promise<SessionInfo> {
  const userAgent = navigator.userAgent;
  const browser = detectBrowser(userAgent);
  const deviceType = detectDeviceType(userAgent);

  return {
    browser,
    device_type: deviceType,
    location: null // Could be implemented with IP geolocation service
  };
}

function detectBrowser(userAgent: string): string {
  if (userAgent.includes('Firefox')) return 'Firefox';
  if (userAgent.includes('Chrome')) return 'Chrome';
  if (userAgent.includes('Safari')) return 'Safari';
  if (userAgent.includes('Edge')) return 'Edge';
  return 'Unknown';
}

function detectDeviceType(userAgent: string): string {
  if (/Mobile|Android|iPhone|iPad|iPod/i.test(userAgent)) return 'mobile';
  if (/Tablet|iPad/i.test(userAgent)) return 'tablet';
  return 'desktop';
}

interface SessionInfo {
  device_type: string;
  browser: string;
  location: string | null;
}

interface UserSettings {
  email_notifications: boolean;
  sms_notifications: boolean;
  language: string;
  timezone: string;
  theme: string;
  accessibility_mode: boolean;
}