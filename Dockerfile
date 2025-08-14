# Use the Alpine Linux base image
FROM python:3.11-alpine@sha256:8d8c6d3808243160605925c2a7ab2dc5c72d0e75651699b0639143613e0855b8

RUN apk update && \
    apk add --no-cache jq \
    curl \
    git \
    openssh-client \
    bash \
    && pip3 install cookiecutter && pip3 install six

COPY *.sh /
RUN chmod +x /*.sh

ENTRYPOINT ["/entrypoint.sh"]
