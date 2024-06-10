# Copyright (c) BDist Development Team
# Distributed under the terms of the Modified BSD License.
FROM quay.io/jupyter/minimal-notebook:2024-06-10

LABEL maintainer="Flavio Martins <flavio.f.martins@tecnico.ulisboa.pt>"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Create the file repository configuration and Import the repository signing key
RUN echo "deb http://apt.postgresql.org/pub/repos/apt jammy-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    wget --no-hsts --quiet -O /etc/apt/trusted.gpg.d/pgdg.asc https://www.postgresql.org/media/keys/ACCC4CF8.asc

# Install the PostgreSQL utilities
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    pspg \
    postgresql-client-12 \
    postgresql-client-13 \
    postgresql-client-14 \
    postgresql-client-15 \
    postgresql-client-16 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# Install PostgreSQL Python drivers
RUN mamba install --yes \
    'psycopg' \
    'psycopg-c' \
    'psycopg-pool' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install PostgreSQL extras
RUN mamba install --yes \
    'pgcli' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install sqlite
RUN mamba install --yes \
    'sqlite' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install sqlite-utils
RUN mamba install --yes \
    'sqlite-utils' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install redis
RUN mamba install --yes \
    'redis-server==7.2.*' \
    'redis-py' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install DuckDB
RUN mamba install --yes \
    'duckdb-cli' \
    'duckdb-engine' \
    'python-duckdb' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install JupySQL
RUN mamba install --yes \
    'jupysql' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install measurement extras
RUN mamba install --yes \
    'jupyter-resource-usage' \
    'jupyterlab_execute_time' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install utility extras
RUN mamba install --yes \
    'jupyter-archive' \
    'jupyterlab-spellchecker' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install Python language server
RUN mamba install --yes \
    'jupyterlab-lsp' \
    'python-lsp-server' \
    'python-lsp-ruff' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install utils
RUN mamba install --yes \
    'fd-find' \
    'file' \
    'git-delta' \
    'git-lfs' \
    'htop' \
    'jc' \
    'jq' \
    'ncdu' \
    'ripgrep' \
    'rclone' \
    'rsync' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}

COPY --chown=${NB_UID}:${NB_GID} ./.psqlrc ${HOME}/.psqlrc
COPY --chown=${NB_UID}:${NB_GID} ./.sqliterc ${HOME}/.sqliterc

WORKDIR "${HOME}"
