FROM alpine:3.22 AS builder
ARG NQPTP_BRANCH=main

RUN apk --update add \
      autoconf \
      automake \
      build-base \
      git \
      linux-headers

WORKDIR /
RUN git clone --depth=1 -b "$NQPTP_BRANCH" https://github.com/mikebrady/nqptp.git \
    && cd nqptp \
    && autoreconf -i \
    && ./configure \
    && make -j $(nproc)

FROM alpine:3.22
COPY --from=builder /nqptp/nqptp /usr/bin/nqptp
ENTRYPOINT ["/usr/bin/nqptp"]
