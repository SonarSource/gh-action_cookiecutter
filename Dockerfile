FROM python:3.11-slim

COPY requirements.txt /tmp/requirements.txt

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    bash \
    curl \
    git \
    jq \
    openssh-client \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --only-binary=:all: --no-cache-dir -r /tmp/requirements.txt

COPY *.sh /
RUN chmod +x /*.sh

ENTRYPOINT ["/entrypoint.sh"]
