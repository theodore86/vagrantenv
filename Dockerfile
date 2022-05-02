FROM ubuntu:20.04

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

ARG HADOLINT_VERSION="2.9.3"

RUN curl -OLs https://github.com/hadolint/hadolint/releases/download/v"${HADOLINT_VERSION}"/hadolint-Linux-x86_64 && \
    mv hadolint-Linux-x86_64 /usr/local/bin/hadolint && \
    chmod a+x /usr/local/bin/hadolint

ARG VAGRANT_VERSION="2.2.19"

RUN curl -OLs https://releases.hashicorp.com/vagrant/"${VAGRANT_VERSION}"/vagrant_"${VAGRANT_VERSION}"_x86_64.deb && \
    dpkg -i vagrant_"${VAGRANT_VERSION}"_x86_64.deb && \
    rm vagrant_"${VAGRANT_VERSION}"_x86_64.deb

ARG BUNDLER_VERSION="2.2.22"

RUN gem install bundler --version "${BUNDLER_VERSION}"

ARG USERNAME="ci" \
    USERGROUP="ci"

WORKDIR /home/"${USERNAME}"

RUN groupadd -r "${USERGROUP}" && \
    useradd -r -g "${USERGROUP}" -d /home/"${USERNAME}" -c "Docker image user" "${USERNAME}" && \
    chown -R "${USERNAME}":"${USERGROUP}" /home/"${USERNAME}"

USER "${USERNAME}"

# See: https://github.com/pypa/pip/issues/10219
ENV LANG="C.UTF-8" \
    PATH="/home/${USERNAME}/.local/bin:${PATH}"

ARG PIP_VERSION="22.0.4" \
    TOX_VERSION="3.24.5"

RUN python3 -m pip install --user --no-cache-dir --upgrade pip=="${PIP_VERSION}" && \
    python3 -m pip install --user --no-cache-dir tox=="${TOX_VERSION}"

ENV BUNDLE_PATH="/home/${USERNAME}"
ENV BUNDLE_BIN="${BUNDLE_PATH}/bin"
ENV PATH="${BUNDLE_BIN}:${PATH}"

RUN bundle config set without "development test"

CMD ["bash"]
