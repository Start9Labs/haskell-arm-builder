FROM arm32v7/debian:buster

RUN apt-get update
RUN apt-get install -y ca-certificates zlib1g-dev libatomic1 netbase libgmp-dev libtinfo5 make xz-utils build-essential
ADD stack-arm-bin /usr/local/bin/stack
RUN mkdir -p /root/haskell/src
WORKDIR /root/haskell/src