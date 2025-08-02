FROM alpine:3.22 AS builder
ARG ALAC_BRANCH=master
ARG SHAIRPORT_SYNC_BRANCH=master

RUN apk -U add \
    alsa-lib-dev \
    autoconf \
    automake \
    avahi-dev \
    build-base \
    dbus-dev \
    ffmpeg-dev \
    git \
    libconfig-dev \
    libgcrypt-dev \
    libplist-dev \
    libsndfile-dev \
    libsodium-dev \
    libtool \
    mosquitto-dev \
    openssl-dev \
    pipewire-dev \
    popt-dev \
    pulseaudio-dev \
    soxr-dev \
    xxd

WORKDIR /
RUN git clone --depth=1 -b "$ALAC_BRANCH" https://github.com/mikebrady/alac.git \
    && cd alac \
    && autoreconf -i \
    && ./configure \
    && make -j $(nproc) \
    && make install \
    && DESTDIR=/alac make install

WORKDIR /
RUN git clone --depth=1 -b "$SHAIRPORT_SYNC_BRANCH" https://github.com/mikebrady/shairport-sync.git \
    && cd shairport-sync \
    && autoreconf -i \
    && CFLAGS="-O3" CXXFLAGS="-O3" ./configure \
        --sysconfdir=/etc \
        --with-airplay-2 \
        --with-alsa \
        --with-apple-alac \
        --with-avahi \
        --with-convolution \
        --with-dbus-interface \
        --with-dummy \
        --with-metadata \
        --with-mpris-interface \
        --with-mqtt-client \
        --with-pa \
        --with-pipe \
        --with-pw \
        --with-soxr \
        --with-ssl=openssl \
        --with-stdout \
    && make -j $(nproc)

FROM alpine:3.22

RUN apk -U add \
    alsa-lib \
    avahi-libs \
    dbus-libs \
    ffmpeg-libs \
    libconfig \
    libgcrypt \
    libplist \
    libsndfile \
    libsodium \
    libuuid \
    mosquitto-libs \
    openssl \
    pipewire-libs \
    popt \
    soxr

COPY --from=builder /alac/usr/local/lib /usr/lib/
COPY --from=builder /shairport-sync/shairport-sync /usr/bin/shairport-sync
ENTRYPOINT ["/usr/bin/shairport-sync"]

