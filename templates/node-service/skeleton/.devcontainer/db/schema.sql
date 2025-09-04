-- Schema for excursions table
CREATE TABLE IF NOT EXISTS excursions (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  location TEXT NOT NULL,
  price NUMERIC(10,2) NOT NULL,
  duration NUMERIC(5,2) NOT NULL,
  max_participants INT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
