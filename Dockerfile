FROM ubuntu:24.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    gcc \
    make \
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

ARG HADOLINT_VERSION="2.12.0"

RUN curl -OLs https://github.com/hadolint/hadolint/releases/download/v"${HADOLINT_VERSION}"/hadolint-Linux-x86_64 && \
    mv hadolint-Linux-x86_64 /usr/local/bin/hadolint && \
    chmod a+x /usr/local/bin/hadolint

ARG VAGRANT_VERSION="2.4.0"

RUN if dpkg --compare-versions "${VAGRANT_VERSION}" ge 2.3.0; then \
    VERSION="${VAGRANT_VERSION}-1"; \
    ARCH=amd64; \
    else \
    VERSION="${VAGRANT_VERSION}"; \
    ARCH=x86_64; \
    fi && \
    curl -OLs https://releases.hashicorp.com/vagrant/"${VAGRANT_VERSION}"/vagrant_"${VERSION}"_"${ARCH}".deb && \
    dpkg -i vagrant_"${VERSION}"_"${ARCH}".deb && \
    rm vagrant_"${VERSION}"_"${ARCH}".deb

ARG BUNDLER_VERSION="2.4.18"

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

ARG PIP_VERSION="23.2.1" \
    TOX_VERSION="4.6.4"

RUN python3 -m pip install --user --no-compile --no-cache-dir --upgrade pip=="${PIP_VERSION}" && \
    python3 -m pip install --user --no-compile --no-cache-dir tox=="${TOX_VERSION}"

ENV BUNDLE_PATH="/home/${USERNAME}"
ENV BUNDLE_BIN="${BUNDLE_PATH}/bin"
ENV PATH="${BUNDLE_BIN}:${PATH}"

RUN bundle config set without "development test"

CMD ["bash"]
