FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/spotify"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates file libasound2t64 libayatana-appindicator3-1 libnss3 && \
    cpak-clean-junk
