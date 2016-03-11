FROM ubuntu:trusty

# Localization
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install software
RUN apt-get install -y software-properties-common
RUN apt-add-repository multiverse
RUN add-apt-repository ppa:mc3man/trusty-media -y
RUN apt-get update -q
RUN apt-get dist-upgrade -y
RUN apt-get install -y mplayer git gcc yasm make transcode ffmpeg mkvtoolnix coreutils python mediainfo

# Build x264
RUN git clone git://git.videolan.org/x264.git
WORKDIR x264
RUN git checkout stable && ./configure && make install

# Download my video tools
WORKDIR /
RUN git clone  https://github.com/say42/video-tools.git

# Make work dirs for volumes
RUN mkdir -p /home/vlab /home/video

CMD /bin/bash
