# Copyright (c) Flavio Martins.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/scipy-notebook:2023-04-10

LABEL maintainer="Flavio Martins <flavio.f.martins@tecnico.ulisboa.pt>"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Node.js-based language servers
RUN npm install -g --save-dev \
    sql-language-server


USER ${NB_UID}

# Install Python 3 packages
RUN mamba install --yes \
    'duckdb-engine' \
    'python-duckdb' \
    'psycopg' \
    'psycopg-c' \
    'jupyterlab-lsp' \
    'python-lsp-server' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install jupysql and dependencies
RUN pip install --quiet --no-cache-dir \
    'git+https://github.com/ploomber/jupysql.git@master' \
    'pgspecial==2.0.1' \
    'psycopg2' \
    'psycopg2-binary'  && \
    fix-permissions "/home/${NB_USER}"
