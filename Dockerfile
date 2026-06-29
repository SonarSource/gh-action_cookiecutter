FROM python:3.11-alpine

COPY requirements.txt /tmp/requirements.txt

RUN apk add --no-cache \
    bash \
    curl \
    git \
    jq \
    openssh-client \
    && pip3 install --upgrade pip \
    && pip3 install --only-binary=:all: --no-cache-dir -r /tmp/requirements.txt

COPY *.sh /
RUN chmod +x /*.sh

ENTRYPOINT ["/entrypoint.sh"]
