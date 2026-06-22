#!/bin/bash
set -e

echo "==> Running database schema initialization..."

# Install psql if not present
if ! command -v psql &> /dev/null; then
    apt-get update -qq && apt-get install -y -qq postgresql-client
fi

# Run schema using the DB_URL environment variable
# DB_URL format: jdbc:postgresql://host:port/dbname
# Extract host, port, dbname from DB_URL
if [ -n "$DB_URL" ]; then
    # Strip jdbc: prefix to get the raw URL
    RAW_URL="${DB_URL#jdbc:}"
    psql "$RAW_URL" -U "$DB_USER" -f /init_schema.sql || echo "Schema already initialized or error (continuing...)"
fi

echo "==> Starting Tomcat..."
exec catalina.sh run
