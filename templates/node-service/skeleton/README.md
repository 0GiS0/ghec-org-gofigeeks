# ${{values.name}}

> Production-ready Node.js template: instant developer environment with Express API, Postgres (Dev Container), tests, linting, docs, CI, and continuous security scanning.

## 🧬 Template Superpowers

| Capability               | Description                                                                                                                       |
| ------------------------ | --------------------------------------------------------------------------------------------------------------------------------- |
| Dev Container + Postgres | `.devcontainer/compose.yml` spins up `app` (Node 20) and `db` (Postgres) plus an init script (`init.sh`) applying schema + seed.  |
| Ready-to-use API         | Express controllers & routes (`src/controllers`, `src/routes`) with a sample `excursions` feature.                                |
| Integrated Database      | Connection env vars pre-configured (`PGHOST=db`, `PGDATABASE=app_db`). Automatic schema + seed for instant data.                  |
| Unit & Integration Tests | Jest + Supertest (`tests/api.test.js`) with coverage (`coverage/`) and ephemeral PostgreSQL via Testcontainers (no shared state). |
| Lint & Quality Gate      | ESLint (`eslint.config.js`) locally & in CI.                                                                                      |
| Automated CI             | `.github/workflows/ci.yml` runs lint, tests, coverage artifact.                                                                   |
| Security (GHAS)          | Dependabot + Code Scanning (CodeQL default org setup).                                                                            |
| Living Documentation     | MkDocs (`mkdocs.yml`, `docs/`) covering quickstart, architecture, API, operations, reference.                                     |
| Opinionated Structure    | Clear layout: `src/`, `tests/`, `docs/`, `coverage/`, `.devcontainer/`.                                                           |
| Environment Example      | `.env.example` ready to copy.                                                                                                     |
| Observability Ready      | Placeholders for logging / tracing in `.env.example`.                                                                             |

### Core Structure

```
.devcontainer/
.github/workflows/ci.yml
src/
  controllers/
  models/
  routes/
  index.js
tests/
docs/
.env.example
```

### 1-Minute Onboarding

```bash
# Inside VS Code -> Reopen in Container
yarn install # or npm install
yarn dev     # or npm run dev
open http://localhost:3000
```

Quality & feedback:

```bash
yarn test        # or npm test
yarn lint        # or npm run lint
```

### Environment & Database

Copy `.env.example` to `.env` when running outside the Dev Container. Inside the container defaults are already injected:

```
PGHOST=db
PGPORT=5432
PGDATABASE=app_db
PGUSER=app_user
PGPASSWORD=app_password
```

The init script `.devcontainer/db/init.sh` applies `schema.sql` + `seed.sql` only once (idempotent logic ensured in SQL). Replace with migrations later if needed.

### Documentation

Full documentation lives in `docs/` and is built with MkDocs Material.

- Quickstart: `docs/guide/quickstart.md`
- Architecture: `docs/architecture/overview.md`
- API: `docs/api/`
- Operations: `docs/operations/`
- Reference: `docs/reference/`

Local docs server:

```bash
npm run docs:serve
# or
mkdocs serve
```

### Production Run

```bash
npm start
```

### Security & Maintenance

- Dependabot automates dependency updates
- GitHub Advanced Security (CodeQL) scanning enabled via org defaults (no extra workflow needed)
- Extend with policies / IaC scanning without modifying core template

---

${{values.description}}

## API Sample Endpoints

(For discovery; move or expand in `docs/api/` when evolving.)

- `GET /health`
- `GET /api/hello`
- `GET /api/status`

## Contributing / Next Steps

1. Create a new feature branch `feat/<name>`
2. Commit with conventional messages (optional but recommended)
3. Open PR – CI will validate lint + tests
4. Update docs alongside code changes

## License

Specify your license here (e.g., MIT) or add a `LICENSE` file.
