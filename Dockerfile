# Start with an Ubuntu 18.04 LTS image.
FROM ubuntu:bionic
MAINTAINER Bryan Cochrane "bryan.cochrane@gmail.com"
# Update package list.
RUN apt-get update
# Upgrade all packages.
RUN apt-get dist-upgrade -y
# Install required packages - curl to download files, gpg to verify signature and sha256sum to verify checksum.
RUN apt-get install -y \
    gpg \
    curl
# Download the binaries and gpg signed checksums, compare the checksums and proceed to extract the files. Create a non-privileged user (litecoin) and set as owner of the binaries. Move the binaries to the system path /usr/local/bin. If any step fails do not proceed (&&).
RUN curl -O https://download.litecoin.org/litecoin-0.17.1/linux/litecoin-0.17.1-x86_64-linux-gnu.tar.gz && \
    curl -O https://download.litecoin.org/litecoin-0.17.1/linux/litecoin-0.17.1-linux-signatures.asc && \
    gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "FE3348877809386C" && \
    gpg --verify litecoin-0.17.1-linux-signatures.asc && \
    grep -oP '(\w+\W+)?litecoin-0.17.1-x86_64-linux-gnu.tar.gz?' litecoin-0.17.1-linux-signatures.asc|sha256sum -c && \
    tar xfz litecoin-0.17.1-x86_64-linux-gnu.tar.gz && \
    groupadd -r litecoin && useradd -r -g litecoin litecoin && \
    chown -R litecoin:litecoin litecoin-0.17.1 && \
    mv litecoin-0.17.1/bin/* /usr/local/bin && \
    rm -rf litecoin-0.17.1 && \
    mkdir -p /home/litecoin /litecoin && \
    chown -R litecoin:litecoin /home/litecoin /litecoin && \
    echo "server=0" > "/litecoin/litecoin.conf"
USER litecoin
# Start the litecoin daemon and output to console
ENTRYPOINT exec litecoind -datadir=/litecoin