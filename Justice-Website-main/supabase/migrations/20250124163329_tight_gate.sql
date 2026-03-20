-- Create court types and jurisdiction levels as ENUMs safely
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'court_type') THEN
    CREATE TYPE court_type AS ENUM (
      'criminal',
      'civil',
      'family',
      'traffic',
      'probate',
      'juvenile',
      'appeals',
      'tax',
      'bankruptcy'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'jurisdiction_level') THEN
    CREATE TYPE jurisdiction_level AS ENUM (
      'municipal',
      'county',
      'district',
      'state',
      'federal'
    );
  END IF;
END $$;

-- Add new columns to court_locations table safely
DO $$
BEGIN
  -- Add court_type array if not exists
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'court_locations' AND column_name = 'court_type'
  ) THEN
    ALTER TABLE court_locations 
    ADD COLUMN court_type court_type[] DEFAULT '{civil,criminal}'::court_type[];
  END IF;

  -- Add jurisdiction if not exists
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'court_locations' AND column_name = 'jurisdiction'
  ) THEN
    ALTER TABLE court_locations 
    ADD COLUMN jurisdiction jurisdiction_level DEFAULT 'county'::jurisdiction_level;
  END IF;

  -- Add other columns if they don't exist
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'court_locations' AND column_name = 'presiding_judge'
  ) THEN
    ALTER TABLE court_locations ADD COLUMN presiding_judge text;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'court_locations' AND column_name = 'filing_office_hours'
  ) THEN
    ALTER TABLE court_locations ADD COLUMN filing_office_hours text;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'court_locations' AND column_name = 'security_info'
  ) THEN
    ALTER TABLE court_locations ADD COLUMN security_info text;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'court_locations' AND column_name = 'parking_info'
  ) THEN
    ALTER TABLE court_locations ADD COLUMN parking_info text;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'court_locations' AND column_name = 'ada_accessibility'
  ) THEN
    ALTER TABLE court_locations ADD COLUMN ada_accessibility boolean DEFAULT true;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'court_locations' AND column_name = 'languages_supported'
  ) THEN
    ALTER TABLE court_locations ADD COLUMN languages_supported text[] DEFAULT '{English}';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'court_locations' AND column_name = 'electronic_filing'
  ) THEN
    ALTER TABLE court_locations ADD COLUMN electronic_filing boolean DEFAULT false;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'court_locations' AND column_name = 'virtual_hearings'
  ) THEN
    ALTER TABLE court_locations ADD COLUMN virtual_hearings boolean DEFAULT false;
  END IF;
END $$;

-- Create indexes for better performance if they don't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_indexes 
    WHERE tablename = 'court_locations' AND indexname = 'idx_court_locations_county'
  ) THEN
    CREATE INDEX idx_court_locations_county ON court_locations(county_id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_indexes 
    WHERE tablename = 'court_locations' AND indexname = 'idx_court_locations_jurisdiction'
  ) THEN
    CREATE INDEX idx_court_locations_jurisdiction ON court_locations(jurisdiction);
  END IF;
END $$;