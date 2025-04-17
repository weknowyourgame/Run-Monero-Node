FROM debian:bullseye

LABEL version="1.0"

ENV MONERO_VERSION=0.18.3.1
ENV USER=monero

RUN apt-get update && \
    apt-get install -y wget curl gnupg2 tor ca-certificates sudo bzip2 && \
    useradd -m -s /bin/bash $USER

USER $USER
WORKDIR /home/$USER

RUN mkdir -p /home/$USER/.bitmonero

RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        wget -q -O monero.tar.bz2 https://downloads.getmonero.org/cli/monero-linux-x64-v${MONERO_VERSION}.tar.bz2; \
    elif [ "$ARCH" = "aarch64" ]; then \
        wget -q -O monero.tar.bz2 https://downloads.getmonero.org/cli/monero-linux-armv8-v${MONERO_VERSION}.tar.bz2; \
    elif [ "$ARCH" = "armv7l" ]; then \
        wget -q -O monero.tar.bz2 https://downloads.getmonero.org/cli/monero-linux-armv7-v${MONERO_VERSION}.tar.bz2; \
    else \
        echo "Unsupported architecture: $ARCH" && exit 1; \
    fi && \
    mkdir -p temp_dir && \
    tar -xf monero.tar.bz2 -C temp_dir --strip-components=1 && \
    cp temp_dir/monerod /home/$USER/ && \
    cp temp_dir/monero-wallet-cli /home/$USER/ && \
    cp temp_dir/monero-wallet-rpc /home/$USER/ && \
    rm -rf temp_dir monero.tar.bz2

COPY --chown=monero:monero monero.conf /home/monero/.bitmonero/monerod.conf
COPY --chown=monero:monero torrc /etc/tor/torrc
COPY --chown=monero:monero start.sh /home/monero/start.sh

RUN chmod +x /home/monero/start.sh /home/monero/monerod

EXPOSE 18080 18089

CMD ["/home/monero/start.sh"]
