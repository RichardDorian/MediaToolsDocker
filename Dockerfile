FROM debian:bookworm-slim

ARG MAKEMKV_VERSION=1.18.1
ARG TEMP_DIR=/build_tmp

RUN apt update && apt upgrade -y
RUN apt install curl wget -y

WORKDIR ${TEMP_DIR}

# Install ffmpeg
RUN apt install ffmpeg -y

# Install MediaInfo
RUN wget https://mediaarea.net/repo/deb/repo-mediaarea_1.0-25_all.deb && dpkg -i repo-mediaarea_1.0-25_all.deb && apt update -y
RUN apt update && apt install mediainfo -y

# Install MKVToolNix
RUN wget -O /etc/apt/keyrings/gpg-pub-moritzbunkus.gpg https://mkvtoolnix.download/gpg-pub-moritzbunkus.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/debian/ bookworm main" > /etc/apt/sources.list.d/mkvtoolnix.download.list
RUN echo "deb-src [signed-by=/etc/apt/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/debian/ bookworm main" >> /etc/apt/sources.list.d/mkvtoolnix.download.list
RUN apt update && apt install mkvtoolnix -y

# Install MakeMKV (TODO: Build our own ffmpeg so MakeMKV can use the latest libavcodec)
RUN apt install build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev qtbase5-dev zlib1g-dev -y
RUN wget https://www.makemkv.com/download/makemkv-bin-${MAKEMKV_VERSION}.tar.gz && wget https://www.makemkv.com/download/makemkv-oss-${MAKEMKV_VERSION}.tar.gz
RUN tar -xzf makemkv-oss-${MAKEMKV_VERSION}.tar.gz && tar -xzf makemkv-bin-${MAKEMKV_VERSION}.tar.gz
RUN cd makemkv-oss-${MAKEMKV_VERSION} && ./configure && make && make install
RUN cd makemkv-bin-${MAKEMKV_VERSION} && mkdir tmp && echo "accepted" > tmp/eula_accepted && make install

WORKDIR /root
RUN cd && rm -rf ${TEMP_DIR}