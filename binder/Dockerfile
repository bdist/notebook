# Copyright (c) BDist Development Team
# Distributed under the terms of the Modified BSD License.

# https://ghcr.io/bdist/notebook?tab=tags
ARG REGISTRY=ghcr.io
ARG OWNER=bdist
ARG BASE_IMAGE=$REGISTRY/$OWNER/notebook:2025-06-05
FROM $BASE_IMAGE

LABEL maintainer="Flavio Martins <flavio.f.martins@tecnico.ulisboa.pt>"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV TAG="2025-06-05"

COPY --chown=${NB_UID}:${NB_GID} binder/README.ipynb "${HOME}"/README.ipynb

RUN jupyter labextension disable "@jupyterlab/apputils-extension:announcements"

# switch to notebook user
USER ${NB_UID}

# PostgreSQL environment
ENV PGHOST=localhost \
    PGPORT=5432 \
    PGUSER=postgres \
    PGPASSWORD=postgres \
    PGDATABASE=postgres \
    PGDATA="${HOME}/data/pgsql"

# create and own the data directory
RUN mkdir -p "$PGDATA" \
    && chown -R "${NB_UID}:${NB_GID}" "$PGDATA"

# initialize the database
RUN initdb \
    --username="$PGUSER" \
    --pwfile=<(printf "%s\n" "$PGPASSWORD")

# start the PostgreSQL server
RUN pg_ctl -D "$PGDATA" -l "$PGDATA/postgresql.log" start
