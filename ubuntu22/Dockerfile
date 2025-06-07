#===========
#Build Stage
# docker build --build-arg UNAME=$USER --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t ubuntu:22.04 ubuntu22
#===========
FROM ubuntu:22.04 as build


RUN apt update

#===========
#Create users
#===========
ARG UNAME=testuser
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

RUN usermod -s /bin/bash $UNAME
RUN echo $UNAME:rootroot | chpasswd

RUN apt-get -y update
RUN apt-get -y install -y git-core gnupg wget net-tools

RUN mkdir -p /usr/share/share/applications
RUN mkdir -p /usr/local/share/applications
RUN chown -R linux:linux /usr/share/share/applications
RUN chown -R linux:linux /usr/local/share/applications

#===========
#Create install locales
#===========
RUN apt-get install locales
RUN locale-gen en_US.UTF-8
RUN echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
RUN echo 'LANG=en_US.UTF-8' >> /etc/environment
RUN echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
RUN echo 'USER=linux' >> /etc/environment

#==================
# Set the locale
#==================
#RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
#    locale-gen
#ENV LANG en_US.UTF-8  
#ENV LANGUAGE en_US.UTF-8  
#ENV LC_ALL en_US.UTF-8  

#==================
# ssh configuration
#==================
#Install sshd
#RUN apt-get update && apt-get install -y openssh-server
#RUN mkdir /var/run/sshd
#RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "export DISPLAY=:0" >> /etc/bash.bashrc

#==================
#Install Yocto essentials
#==================
ENV DEBIAN_FRONTEND=noninteractive
# Required Packages for the Host Development System
# http://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#required-packages-for-the-host-development-system
#RUN apt install -y gawk wget git-core diffstat unzip texinfo gcc-multilib \
#        build-essential chrpath socat cpio python3 python3-pip python3-pexpect python-is-python3 \
#        xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
#        pylint3 xterm        

RUN apt install -y gawk wget git git-core diffstat unzip texinfo gcc-multilib build-essential
RUN apt install -y chrpath socat cpio python3 python3-pip python3-pexpect
RUN apt install -y python3-git python3-jinja2 libegl1-mesa rsync bc bison
RUN apt install -y xz-utils debianutils iputils-ping libsdl1.2-dev xterm
RUN apt install -y language-pack-en coreutils texi2html file docbook-utils
RUN apt install -y help2man desktop-file-utils
RUN apt install -y libgl1-mesa-dev libglu1-mesa-dev mercurial autoconf automake
RUN apt install -y groff curl lzop asciidoc u-boot-tools libreoffice-writer
RUN apt install -y sshpass ssh-askpass zip xz-utils zstd liblz4-tool kpartx vim screen cmake

# Additional host packages required by poky/scripts/wic
RUN apt install -y curl dosfstools mtools parted syslinux tree zip \
docbook-utils help2man make gcc g++ desktop-file-utils \
libgl1-mesa-dev libglu1-mesa-dev mercurial autoconf automake groff curl lzop asciidoc protobuf-compiler \
dfu-util device-tree-compiler ninja-build

RUN apt-get update 
RUN apt-get upgrade

# Install ZeroMQ and its development files
RUN apt-get install -y libzmq3-dev

#Install dependencies for Zephyr OS
RUN pip install west
RUN pip install patool
RUN pip install requests
RUN pip install semver
RUN pip install tqdm
RUN pip install pyelftools
RUN pip install intelhex
RUN pip install serial
RUN pip install pyserial

#==================
#Set default entrypoint and command
#==================
USER $UNAME
ENV USER=$UNAME \
    SHELL=/bin/bash
CMD /bin/bash
