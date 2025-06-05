#!/bin/bash
pg_ctl -D "$PGDATA" -l "$PGDATA/postgresql.log" start
echo "PostgreSQL started. Log available at $PGDATA/postgresql.log"
