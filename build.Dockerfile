FROM debian:bullseye

# Install prerequisites
RUN apt-get update && apt-get install -y build-essential pkg-config autoconf libtool ccache make cmake gcc g++ git curl lbzip2 libtinfo5 gperf gcc-aarch64-linux-gnu g++-aarch64-linux-gnu gcc-i686-linux-gnu g++-i686-linux-gnu

RUN groupadd -g 1000 build && \
    useradd -m -u 1000 -g build -s /bin/bash build && \
    echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER build
WORKDIR /home/build

RUN git config --global --add safe.directory '*' && \
    git config --global user.email "ci@mrcyjanek.net" && \
    git config --global user.name "CI mrcyjanek.net"

RUN git clone https://github.com/mrcyjanek/monero_c --recursive && \
    cd monero_c && \
    ./apply_patches.sh monero

WORKDIR /home/build/monero_c

RUN ./build_single.sh monero aarch64-linux-gnu -j$(nproc)

RUN shasum -a 256  release/monero/aarch64-linux-gnu_libwallet2_api_c.so.xz > hashes.txt