# Copyright (c) BDist Development Team
# Distributed under the terms of the Modified BSD License.

# https://ghcr.io/bdist/notebook?tab=tags
ARG REGISTRY=ghcr.io
ARG OWNER=bdist
ARG BASE_IMAGE=$REGISTRY/$OWNER/notebook:2025-06-02
FROM $BASE_IMAGE

LABEL maintainer="Flavio Martins <flavio.f.martins@tecnico.ulisboa.pt>"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV TAG="2025-06-02"

COPY --chown=${NB_UID}:${NB_GID} binder/README.ipynb "${HOME}"/README.ipynb

RUN jupyter labextension disable "@jupyterlab/apputils-extension:announcements"
