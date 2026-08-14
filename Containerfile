FROM ubuntu:26.04 AS source

ADD --checksum=sha256:98a9310173563965be5cd306b25a219823f9c0da809fda9bf51a34c9638578d0 \
    https://api.snapcraft.io/api/v1/snaps/download/pOBIoZ2LrCB3rDohMxoYGnbN14EHOgD7_97.snap \
    /tmp/spotify.snap

RUN apt-get update && \
    apt-get install -y --no-install-recommends squashfs-tools && \
    unsquashfs -d /out /tmp/spotify.snap

FROM ghcr.io/containerpak/gtk3:main

COPY --from=source /out/usr/ /usr/
COPY spotify /usr/local/lib/cpak/spotify

RUN apt update && \
    apt install -y --no-install-recommends \
      file libasound2t64 libayatana-appindicator3-1 libnss3 && \
    install -m 0755 /usr/local/lib/cpak/spotify /usr/bin/spotify && \
    cpak-clean-junk
