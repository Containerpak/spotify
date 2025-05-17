FROM ghcr.io/containerpak/mesa@sha256:79d69be1e64e105aa86a6bcfb492f15268d568fb0adfc6450c88bbed3c9a8e91

RUN apt update && apt install -y \
    curl \
    squashfs-tools \
    file && \
    libasound2t64 && \
    rm -rf /var/lib/apt/lists/*

ARG SPOTIFY_SNAP_URL="https://api.snapcraft.io/api/v1/snaps/download/pOBIoZ2LrCB3rDohMxoYGnbN14EHOgD7_86.snap"

RUN mkdir -p /app && \
    curl -L -H "Snap-Device-Series: 16" "${SPOTIFY_SNAP_URL}" -o /tmp/spotify.snap && \
    unsquashfs -d /app/squashfs-root /tmp/spotify.snap && \
    cp -r /app/squashfs-root/usr/* /usr/ && \
    rm -r /tmp/spotify.snap /app/squashfs-root && \
    /usr/bin/cpak-clean-junk
