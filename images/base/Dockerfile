FROM ubuntu:26.04

# Only what crosstool-NG, llvm-mingw, the Android NDK and a dependency-less
# FFmpeg build need. Upstream's image carries a lot more for its external libraries.
ENV DEBIAN_FRONTEND=noninteractive
RUN \
    apt-get -y update && \
    apt-get -y dist-upgrade && \
    apt-get -y install --no-install-recommends \
        ca-certificates build-essential nasm pkgconf \
        curl wget unzip zip xz-utils bzip2 zstd git rsync file patch \
        autoconf automake libtool libtool-bin gawk bison flex texinfo help2man \
        libncurses-dev zlib1g-dev libzstd-dev cmake ninja-build python3 && \
    apt-get -y autoremove && \
    apt-get -y clean autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    git config --global user.email "builder@localhost" && \
    git config --global user.name "Builder" && \
    git config --global advice.detachedHead false

RUN --mount=src=.,dst=/input \
    for s in /input/*.sh; do cp $s /usr/bin/$(echo $s | sed -e 's|.*/||' -e 's/\.sh$//'); done

ENV HOST_CC="gcc" \
    HOST_CXX="g++" \
    HOST_CFLAGS="-O2 -pipe" \
    HOST_CXXFLAGS="-O2 -pipe"
