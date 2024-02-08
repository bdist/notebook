# Copyright (c) BDist Development Team
# Distributed under the terms of the Modified BSD License.
FROM quay.io/jupyter/minimal-notebook:2024-02-06

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
    postgresql-client-12 \
    postgresql-client-13 \
    postgresql-client-14 \
    postgresql-client-15 \
    postgresql-client-16 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


USER ${NB_UID}

# Install sqlite
RUN mamba install --yes \
    'sqlite' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install redis
RUN mamba install --yes \
    'redis-server==7.*' \
    'redis-py' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install PostgreSQL Python drivers v2
RUN mamba install --yes \
    'psycopg2' \
    'psycopg2-binary' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install PostgreSQL Python drivers v3
RUN mamba install --yes \
    'psycopg' \
    'psycopg-c' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install JupySQL
RUN mamba install --yes \
    'jupysql' \
    'pgspecial==2.0.1' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install extras
RUN mamba install --yes \
    'jupyter-archive' \
    'jupyterlab_execute_time' \
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

# Install pgcli
RUN mamba install --yes \
    'pgcli' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}

COPY --chown=${NB_UID}:${NB_GID} ./.psqlrc ${HOME}/.psqlrc
COPY --chown=${NB_UID}:${NB_GID} ./.sqliterc ${HOME}/.sqliterc

WORKDIR "${HOME}"
