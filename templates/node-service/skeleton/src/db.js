const { Pool } = require('pg');

let pool = null;

function getPool() {
  if (!pool) {
    pool = new Pool({
      host: process.env.PGHOST || 'localhost',
      port: parseInt(process.env.PGPORT || '5432', 10),
      user: process.env.PGUSER || 'app_user',
      password: process.env.PGPASSWORD || 'app_password',
      database: process.env.PGDATABASE || 'app_db',
      max: 5,
      idleTimeoutMillis: 10000
    });
  }
  return pool;
}

module.exports = { getPool };
