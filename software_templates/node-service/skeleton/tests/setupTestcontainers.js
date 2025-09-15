/**
 * 🧪 Legacy Inline Testcontainers Setup (Not Active)
 * -------------------------------------------------
 * This file demonstrates an alternative approach where container lifecycle
 * is managed via Jest's `beforeAll/afterAll` inside the test environment itself.
 *
 * CURRENT STATUS: Not referenced by the active Jest configuration.
 * Kept only as an educational example. Preferred approach uses:
 *  - global-setup.js (start container, write metadata)
 *  - setup-test-db.js (inject env + seed)
 *  - global-teardown.js (graceful shutdown)
 *
 * You can delete this file safely once confident with the new flow.
 */
/* eslint-env jest */
/* global beforeAll, afterAll */
const { PostgreSqlContainer } = require("@testcontainers/postgresql");
const { closePool } = require("../src/db");
const fs = require("fs");

// Keep reference across tests
let container;

async function globalSetup() {
  let runtimeAvailable = false;
  runtimeAvailable =
    fs.existsSync("/var/run/docker.sock") || !!process.env.DOCKER_HOST;

  if (runtimeAvailable) {
    try {
      container = await new PostgreSqlContainer()
        .withDatabase("test_db")
        .withUsername("test_user")
        .withPassword("test_password")
        .start();

      process.env.PGHOST = container.getHost();
      process.env.PGPORT = String(container.getPort());
      process.env.PGUSER = container.getUsername();
      process.env.PGPASSWORD = container.getPassword();
      process.env.PGDATABASE = container.getDatabase();
      console.log("[testcontainers] Started ephemeral PostgreSQL container");
    } catch (err) {
      console.warn(
        "[testcontainers] Failed to start container, falling back to existing DB:",
        err.message
      );
    }
  } else {
    console.warn(
      "[testcontainers] No container runtime detected, using existing database configuration"
    );
  }

  // Simple bootstrap schema (mirror minimal production schema subset)
  const { getPool } = require("../src/db");
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

async function globalTeardown() {
  await closePool();
  if (container) {
    await container.stop();
  }
}

beforeAll(async () => {
  await globalSetup();
});
afterAll(async () => {
  await globalTeardown();
});
