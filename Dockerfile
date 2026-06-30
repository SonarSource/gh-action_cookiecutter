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
    && pip3 install --only-binary :all: --no-cache-dir -r /tmp/requirements.txt \
    && groupadd --system --gid 1001 action \
    && useradd --system --uid 1001 --gid action --home-dir /home/action --shell /bin/bash action

COPY *.sh /
RUN chmod +x /*.sh

USER action

ENTRYPOINT ["/entrypoint.sh"]
