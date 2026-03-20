import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables');
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export async function downloadForm(formId: string): Promise<string> {
  try {
    const { data, error } = await supabase.storage
      .from('legal-forms')
      .download(`forms/${formId}.pdf`);

    if (error) {
      throw error;
    }

    if (!data) {
      throw new Error('Form not found');
    }

    // Create a temporary URL for the downloaded file
    const url = URL.createObjectURL(data);
    return url;
  } catch (error) {
    console.error('Error downloading form:', error);
    throw error;
  }
}

// Add regulation analysis functions
export async function getRegulationAnalysis(query: string) {
  const { data, error } = await supabase
    .from('regulation_analysis')
    .select('*')
    .textSearch('title', query)
    .order('created_at', { ascending: false });

  if (error) throw error;
  return data;
}

export async function getConstitutionalTests() {
  const { data, error } = await supabase
    .from('regulation_tests')
    .select('*')
    .eq('is_active', true)
    .order('name');

  if (error) throw error;
  return data;
}

export async function saveAnalysisResult(result: {
  type: 'contradiction' | 'redundancy' | 'constitutional';
  title: string;
  description: string;
  citations: string[];
  severity: 'high' | 'medium' | 'low';
  recommendation?: string;
  constitutional_basis?: string[];
  precedents?: string[];
}) {
  const { data, error } = await supabase
    .from('regulation_analysis')
    .insert([result])
    .select()
    .single();

  if (error) throw error;
  return data;
}