#!/bin/bash
echo 'Setting up stack ARM dir'
mkdir -p ~/.stack-arm
echo 'Bootstrapping Stack 2.5.1'
docker buildx build -f $(pwd)/Dockerfile.bootstrap --platform=linux/arm/v7 -t start9/haskell-arm-cross-bootstrap --load $(pwd)
mkdir -p stack/.stack-work-arm
docker run -it --name stack-builder -v "$HOME/.stack-arm":/root/.stack -v $(pwd)/stack:/root/haskell/src -v $(pwd)/stack/.stack-work-arm:/root/haskell/src/.stack-work start9/haskell-arm-cross-bootstrap:latest
docker cp stack-builder:/root/.local/bin/stack ./stack-arm-bin
docker rm stack-builder
docker buildx build -f $(pwd)/Dockerfile.builder --platform=linux/arm/v7 -t start9/haskell-arm-cross --load $(pwd)