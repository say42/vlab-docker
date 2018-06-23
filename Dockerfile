FROM ubuntu:bionic

# Install software
RUN apt-get update -q
RUN apt-get dist-upgrade -y
RUN apt-get install -y coreutils locales
RUN apt-get install -y mplayer transcode ffmpeg mkvtoolnix mediainfo
RUN apt-get install -y python git

# Localization
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Build x264
#RUN apt-get install -y gcc nasm make
#RUN git clone git://git.videolan.org/x264.git
#WORKDIR x264
#RUN git checkout stable && ./configure --enable-pic && make install

ARG UID
ARG GID

# Download my video tools
WORKDIR /
RUN git clone  https://github.com/say42/video-tools.git

# Create user and group
RUN addgroup --gid $GID vgroup
RUN adduser --uid $UID --gid $GID --disabled-password --disabled-login vuser

# Make work dirs for volumes
VOLUME /home/video
WORKDIR /home/video

USER vuser
CMD /bin/bash
