FROM python:3.11-slim@sha256:b27df5841f3355e9473f9a516d38a6783b6c8dfeacaf2d14a240f443b368ddb6

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    bash \
    curl \
    git \
    jq \
    openssh-client \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --only-binary :all: --no-cache-dir \
    Jinja2==3.1.6 \
    MarkupSafe==3.0.3 \
    PyYAML==6.0.3 \
    Pygments==2.20.0 \
    arrow==1.4.0 \
    binaryornot==0.6.0 \
    certifi==2026.6.17 \
    charset-normalizer==3.4.7 \
    click==8.4.2 \
    cookiecutter==2.6.0 \
    idna==3.18 \
    markdown-it-py==4.2.0 \
    mdurl==0.1.2 \
    python-dateutil==2.9.0.post0 \
    python-slugify==8.0.4 \
    requests==2.34.2 \
    rich==15.0.0 \
    six==1.17.0 \
    text-unidecode==1.3 \
    tzdata==2026.2 \
    urllib3==2.7.0 \
    && groupadd --system --gid 1001 action \
    && useradd --system --uid 1001 --gid action --home-dir /home/action --shell /bin/bash action

COPY *.sh /
RUN chmod +x /*.sh

USER action

ENTRYPOINT ["/entrypoint.sh"]
