/**
 * 🌱 Test DB Seeding (Jest setupFilesAfterEnv)
 * -------------------------------------------
 * Runs inside the Jest test environment AFTER global-setup completed.
 * Responsibilities:
 *  1. Read `pg-test-meta.json` produced by global-setup.
 *  2. Inject dynamic PG* env vars so application code points to the ephemeral DB.
 *  3. Create / migrate minimal schema and seed deterministic sample data.
 *
 * Idempotent: safe to run multiple times (CREATE TABLE IF NOT EXISTS + ON CONFLICT DO NOTHING).
 */
const { readFile } = require("fs/promises");
const path = require("path");
const { getPool } = require("../src/db");

async function seed() {
  const metaPath = path.join(__dirname, "pg-test-meta.json");
  let meta;
  try {
    meta = JSON.parse(await readFile(metaPath, "utf-8"));
  } catch {
    console.warn(
      "[tests] No Testcontainers metadata found, skipping container env injection"
    );
    return;
  }
  process.env.PGHOST = meta.host;
  process.env.PGPORT = String(meta.port);
  process.env.PGUSER = meta.user;
  process.env.PGPASSWORD = meta.password;
  process.env.PGDATABASE = meta.database;

  const pool = getPool();
  await pool.query(`CREATE TABLE IF NOT EXISTS excursions (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    location TEXT NOT NULL,
    price NUMERIC(10,2) NOT NULL DEFAULT 0,
    duration NUMERIC(5,2) NOT NULL DEFAULT 1,
    max_participants INT NOT NULL DEFAULT 1,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
  );`);
  await pool.query(`INSERT INTO excursions (name, description, location, price, duration, max_participants)
    VALUES ('Sample Excursion A','Test A','Test Location A',10,2,10),
           ('Sample Excursion B','Test B','Test Location B',20,3,12)
    ON CONFLICT DO NOTHING;`);
}

module.exports = async () => {
  await seed();
};
