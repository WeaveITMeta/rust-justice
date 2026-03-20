/*
  # Storage Policies for Legal Forms

  1. Changes
    - Enable Row Level Security (RLS) on storage.objects
    - Create policy for public downloads from legal-forms bucket
    - Add security constraints to ensure only PDF files are accessible

  2. Security
    - Restricts access to only PDF files in the legal-forms bucket
    - Prevents access to other buckets or file types
    - Ensures files are only readable, not modifiable
*/

-- Enable RLS on storage.objects if not already enabled
ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

-- Remove any existing policies for the legal-forms bucket
DROP POLICY IF EXISTS "Allow public downloads" ON storage.objects;

-- Create policy for public downloads with additional security constraints
CREATE POLICY "Allow public downloads"
ON storage.objects
FOR SELECT
USING (
  bucket_id = 'legal-forms' AND 
  -- Ensure only files in the forms directory are accessible
  (storage.foldername(name))[1] = 'forms' AND
  -- Only allow PDF files
  lower(substring(name from '\.([^\.]+)$')) = 'pdf'
);

-- Ensure the legal-forms bucket exists
DO $$
BEGIN
  INSERT INTO storage.buckets (id, name)
  VALUES ('legal-forms', 'legal-forms')
  ON CONFLICT (id) DO NOTHING;
END $$;