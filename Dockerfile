ARG BASE_IMAGE=ghcr.io/lsst-dm/docker-scipipe:9-latest
FROM $BASE_IMAGE

ARG LSST_SPLENV_REF
ARG NEW_DIR=/opt/lsst/software/stack
ARG LSST_USER=lsst
ARG LSSTINSTALL_URL=https://ls.st/lsstinstall
ARG LSST_EUPS_PKGROOT_BASE_URL=https://eups.lsst.codes/stack

USER root

RUN mkdir -p "$NEW_DIR"
RUN groupadd "$LSST_USER"
RUN useradd -g "$LSST_USER" -m "$LSST_USER"
RUN chown "${LSST_USER}:${LSST_USER}" "$NEW_DIR"

USER $LSST_USER
WORKDIR $NEW_DIR

SHELL ["/bin/bash", "-o", "pipefail", "-lc"]
RUN <<EOF
  set -e
  curl -sSL "$LSSTINSTALL_URL" | bash -s -- -S -v ${LSST_SPLENV_REF}
  source ./loadLSST.sh
  conda clean -a -y
EOF
SHELL ["/bin/bash", "-lc"]
