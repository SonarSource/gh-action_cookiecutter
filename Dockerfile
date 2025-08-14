# Use the Alpine Linux base image
FROM python:3.13-alpine@sha256:af1fd7a973d8adc761ee6b9d362b99329b39eb096ea3c53b8838f99bd187011e

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
