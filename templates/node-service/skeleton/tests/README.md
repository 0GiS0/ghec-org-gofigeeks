# Testcontainers PostgreSQL Setup

This directory documents how the automated ephemeral PostgreSQL test environment works in this repository using **Testcontainers**.

## Why Testcontainers?

Ephemeral containers give each test run an isolated, production‑like database:

- Reproducible (clean schema + seed every run)
- No cross‑test coupling or leftover state
- Mirrors real Postgres behavior (constraints, types, defaults)
- Safe for parallel CI agents

## High‑Level Flow

1. **Jest globalSetup** (`global-setup.js`)
   - Starts a PostgreSQL container via `@testcontainers/postgresql`.
   - Captures connection metadata (host, port, user, password, database, container id).
   - Persists it to `pg-test-meta.json` and exposes the container id through `process.env.__PG_TESTCONTAINERS_ID__`.
2. **Jest setupFilesAfterEnv** (`setup-test-db.js`)
   - Reads `pg-test-meta.json`.
   - Injects `PGHOST/PGPORT/PGUSER/PGPASSWORD/PGDATABASE` into `process.env`.
   - Lazily creates a pg `Pool` (via `getPool`) and applies schema + seed data.
3. **Tests execute** (e.g. `api.test.js`)
   - Application code calls `getPool()`; connections point to the ephemeral DB.
4. **Jest globalTeardown** (`global-teardown.js`)
   - Calls `closePool()` to gracefully drain and end the pool.
   - Stops and removes the container (`docker stop` then `docker rm`).
   - Deletes `pg-test-meta.json`.

## Key Files

| File                 | Purpose                                                           |
| -------------------- | ----------------------------------------------------------------- |
| `global-setup.js`    | Starts the PostgreSQL container and writes metadata.              |
| `setup-test-db.js`   | Loads metadata, sets env vars, creates tables + seed rows.        |
| `global-teardown.js` | Gracefully shuts down the pool and destroys the container.        |
| `src/db.js`          | Provides `getPool()` / `closePool()` with safe shutdown handling. |
| `api.test.js`        | Example integration tests using the seeded data.                  |

Legacy / exploratory files kept for reference (not wired into Jest config):

- `setupTestcontainers.js`
- `test-environment.js`

## Environment Variable Mapping

The Testcontainers API returns dynamic values (especially `host` + random `port`). We map them to the standard PostgreSQL env vars so application code stays unchanged:

| Env Var      | Source                    |
| ------------ | ------------------------- |
| `PGHOST`     | `container.getHost()`     |
| `PGPORT`     | `container.getPort()`     |
| `PGUSER`     | `container.getUsername()` |
| `PGPASSWORD` | `container.getPassword()` |
| `PGDATABASE` | `container.getDatabase()` |

## Connection Pool Lifecycle (`src/db.js`)

- Pool created lazily on first `getPool()` call (using current env vars).
- `closePool()` marks shutdown and ends the pool.
- Error handler suppresses expected `57P01` ("terminating connection due to administrator command") when the container stops.

## Seeding Strategy

`setup-test-db.js` ensures a minimal table + sample rows:

- Table: `excursions`
- Two initial sample rows (A & B)
- Idempotent: guarded by `CREATE TABLE IF NOT EXISTS` and `ON CONFLICT DO NOTHING`.

Extend by adding more `CREATE TABLE` or `INSERT` statements in `setup-test-db.js` (or refactor to load SQL files).

## Running Tests

Standard run (uses Testcontainers automatically via Jest global hooks):

```bash
npm test
```

With coverage:

```bash
npm run test:coverage
```

Serial (if debugging container startup issues):

```bash
npm run test:containers
```

> The `test:containers` script forces `--runInBand`; otherwise normal parallelism is fine because one container serves the suite.

## Customizing the Container

Modify in `global-setup.js` before `.start()`:

```js
new PostgreSqlContainer()
  .withDatabase("test_db")
  .withUsername("test_user")
  .withPassword("test_password");
// .withReuse()            // enable reusable container (opt-in, local only)
// .withTmpFs({ '/var/lib/postgresql/data': 'rw' }) // example tmpfs
```

Add environment tweaks via `.withEnv(key, value)` if needed.

## Adding More Tables

Place schema SQL directly in `setup-test-db.js` or extract to `/tests/sql/*.sql` and load with `fs.readFileSync` then `pool.query(sql)`. Keep creation idempotent to support repeated local runs.

## Troubleshooting

| Symptom                                      | Cause                                                    | Fix                                                                                  |
| -------------------------------------------- | -------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `Could not find a working container runtime` | Docker socket not mounted or Docker Desktop not running. | Ensure `/var/run/docker.sock` is available (devcontainer compose already mounts it). |
| Tests hang on teardown                       | Pool not closed before container stop.                   | Confirm `closePool()` is called (already in `global-teardown.js`).                   |
| FATAL `57P01` crash after tests              | Forced container kill before pool close.                 | Fixed by graceful teardown; ensure you use current scripts.                          |
| Port collisions                              | Rare; container uses random host port.                   | Usually none; inspect `pg-test-meta.json` if curious.                                |
| Need to inspect DB contents                  | Run `docker exec -it <id> psql -U test_user -d test_db`. | Container ID stored in metadata & exposed in env `__PG_TESTCONTAINERS_ID__`.         |

## CI Considerations

- Works in any CI runner with Docker available.
- If using a remote shared runner without privileged Docker, you may need a fallback path (e.g., a test Postgres service); adapt `global-setup.js` to detect failure and skip.
- Avoid `withReuse()` in CI (non-deterministic state leakage).

## Extending Further

Potential enhancements:

- Auto-migrate using a migration tool (e.g. `node-pg-migrate`) instead of inline SQL.
- Split seed vs schema for clarity.
- Add a health-check query loop before seeding for large schema setups.
- Introduce per-test transactions with rollback (wrap each test in BEGIN/ROLLBACK via a custom Jest environment or helper).

## Minimal Mental Model

```
Jest start → global-setup spins up container → metadata saved → setup-test-db sets env + seeds → tests run using pool → global-teardown closes pool & stops container → clean slate
```

## Safe Deletions / Cleanup

If you decide to remove Testcontainers later:

1. Delete `global-setup.js`, `global-teardown.js`, `setup-test-db.js`.
2. Remove Jest config entries from `package.json` (globalSetup/globalTeardown/setupFilesAfterEnv).
3. Set static `PG*` env vars in `.env` for a persistent dev DB.

---

Feel free to adapt this README as the test infrastructure evolves.
