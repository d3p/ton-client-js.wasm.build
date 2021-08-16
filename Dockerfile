FROM rust:1.51.0 as build
ENV NVM_DIR=/usr/local/nvm \
    NODE_VERSION=14.17.4
RUN groupadd --gid 1000 jenkins && \
    adduser --uid 1000 --home /tonlabs/TON-SDK --disabled-password --ingroup jenkins --system jenkins && \
    mkdir -p /usr/local/nvm && \
    curl -sSLfo- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash && \
    \. "$NVM_DIR/nvm.sh" &&\
    nvm install $NODE_VERSION --latest-npm --default && \
    nvm alias default $NODE_VERSION && \
    nvm use default && \
    apt-get update && \
    apt-get install -y lsb-release software-properties-common \
    libnss3 libxss1 libasound2 libdbus-glib-1-2 \
    libxt6 ffmpeg libwoff1 libopus0 libwebp6 libwebpdemux2 \
    libenchant1c2a libgudev-1.0-0 libsecret-1-0 libhyphen0 \
    libgdk-pixbuf2.0-0 libegl1 libnotify4 libxslt1.1 libevent-2.1-6 \
    libgles2 libvpx5 libgstreamer1.0-0 libharfbuzz-icu0 \
    libgstreamer-plugins-base1.0-0 libgstreamer-gl1.0-0 \
    libgstreamer-plugins-bad1.0-0 \
    moreutils build-essential gcc-multilib libssl-dev && \
    add-apt-repository 'deb http://deb.debian.org/debian buster-backports main' && \
    apt-get update && \
    apt-get install -y clang-8 lldb-8 lld-8 clangd-8 lldb-8 lld-8 clangd-8 && \
    ln -s /usr/bin/clang-8 /usr/bin/clang;
ENV NODE_PATH="$NVM_DIR/v$NODE_VERSION/lib/node_modules" \
    PATH="$NVM_DIR/versions/node/v$NODE_VERSION/bin:${PATH}"

RUN echo "#!/bin/bash\n" \
    "cd /tonlabs/TON-SDK/packages/lib-web/build &&\n" \
    "uname -a && id && pwd && cargo --version && rustc --version && clang --version && npm --versions &&\n" \
    "cargo run" > /usr/bin/build-tonclient-wasm.sh && \
    chmod +x /usr/bin/build-tonclient-wasm.sh

WORKDIR /tonlabs/TON-SDK
VOLUME ["/tonlabs/TON-SDK"]
