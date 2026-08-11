FROM ubuntu:26.04 AS source

ADD --checksum=sha256:98a9310173563965be5cd306b25a219823f9c0da809fda9bf51a34c9638578d0 \
    https://api.snapcraft.io/api/v1/snaps/download/pOBIoZ2LrCB3rDohMxoYGnbN14EHOgD7_97.snap \
    /tmp/spotify.snap

FROM ghcr.io/containerpak/gtk:main

COPY --from=source /tmp/spotify.snap /tmp/spotify.snap
COPY spotify /usr/local/lib/cpak/spotify

RUN apt update && \
    apt install -y --no-install-recommends \
      file libasound2t64 libayatana-appindicator3-1 libnss3 squashfs-tools && \
    unsquashfs -d /tmp/spotify-root /tmp/spotify.snap && \
    cp -a /tmp/spotify-root/usr/. /usr/ && \
    install -m 0755 /usr/local/lib/cpak/spotify /usr/bin/spotify && \
    rm -rf /tmp/spotify.snap /tmp/spotify-root && \
    cpak-clean-junk
