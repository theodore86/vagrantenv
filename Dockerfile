FROM ubuntu:20.04

# Update system, install system dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    gcc \
    git \
    curl \
    openssh-client \
    ca-certificates \
    tar \
    gzip \
    ruby-dev \
    python3-setuptools \
    python3-pip \
    python3-dev && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

WORKDIR /app

# Install ruby bundler
ARG BUNDLER_VERSION="2.2.22"

RUN echo 'gem: --no-document' > /etc/gemrc && \
    gem install bundler -v "${BUNDLER_VERSION}" && \
    bundle config --global silence_root_warning 1

# Install hadolint
ARG HADOLINT_VERSION="2.9.3"

RUN curl -OLs https://github.com/hadolint/hadolint/releases/download/v"${HADOLINT_VERSION}"/hadolint-Linux-x86_64 && \
    mv hadolint-Linux-x86_64 /usr/local/bin/hadolint && \
    chmod a+x /usr/local/bin/hadolint

# Install Vagrant
ARG VAGRANT_VERSION="2.2.19"

RUN curl -OLs https://releases.hashicorp.com/vagrant/"${VAGRANT_VERSION}"/vagrant_"${VAGRANT_VERSION}"_x86_64.deb && \
    dpkg -i vagrant_"${VAGRANT_VERSION}"_x86_64.deb && \
    rm vagrant_"${VAGRANT_VERSION}"_x86_64.deb

# See: https://github.com/pypa/pip/issues/10219
ENV LANG="C.UTF-8"

# Install Tox automation tool
ARG PIP_VERSION="22.0.4" \
    TOX_VERSION="3.24.5"

RUN python3 -m pip install --no-cache-dir --upgrade pip=="${PIP_VERSION}" && \
    python3 -m pip install --no-cache-dir tox=="${TOX_VERSION}"

ENV PRE_COMMIT_HOME="/app/.cache/pre-commit" \
    TERM="xterm-256color"

CMD ["tox", "-e", "linters"]
