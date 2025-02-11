FROM docker.io/library/alpine:latest

WORKDIR /tmp

COPY --chown=root:root etc etc
COPY --chown=root:root root root

ARG OUTFILE

RUN tar -cvzf /out/${OUTFILE} etc root
