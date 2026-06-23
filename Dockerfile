# Use the Alpine Linux base image
FROM python:3.14-alpine@sha256:26730869004e2b9c4b9ad09cab8625e81d256d1ce97e72df5520e806b1709f92

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
