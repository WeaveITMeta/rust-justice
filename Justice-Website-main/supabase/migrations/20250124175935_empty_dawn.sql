-- Create document metadata table
CREATE TABLE IF NOT EXISTS public.document_metadata (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  file_path text NOT NULL UNIQUE,
  description text,
  category text NOT NULL DEFAULT 'General Forms',
  tags text[] DEFAULT '{}',
  uploaded_by uuid REFERENCES public.profiles(id),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE public.document_metadata ENABLE ROW LEVEL SECURITY;

-- Create policies for document metadata
CREATE POLICY "Users can view document metadata"
  ON public.document_metadata
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Administrators can manage document metadata"
  ON public.document_metadata
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.roles r ON ur.role_id = r.id
      WHERE ur.user_id = auth.uid() AND r.name = 'administrator'
    )
  );

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_document_metadata_file_path ON public.document_metadata(file_path);
CREATE INDEX IF NOT EXISTS idx_document_metadata_category ON public.document_metadata(category);
CREATE INDEX IF NOT EXISTS idx_document_metadata_uploaded_by ON public.document_metadata(uploaded_by);

-- Create function to update metadata timestamps
CREATE OR REPLACE FUNCTION update_document_metadata_timestamp()
RETURNS trigger AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for updating timestamps
CREATE TRIGGER update_document_metadata_timestamp
  BEFORE UPDATE ON public.document_metadata
  FOR EACH ROW
  EXECUTE FUNCTION update_document_metadata_timestamp();