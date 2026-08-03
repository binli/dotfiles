ARG UBUNTU_VERSION=24.04

FROM docker.m.daocloud.io/library/ubuntu:${UBUNTU_VERSION}
#FROM ubuntu:${UBUNTU_VERSION}

ARG USERNAME=ubuntu

RUN --mount=type=secret,id=ubuntu \
    chpasswd < /run/secrets/ubuntu

RUN mkdir -p /etc/sudoers.d/ \
    && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu


ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update; apt-get -y install devscripts debhelper dh-modaliases git vim sudo ubuntu-dev-tools python3-jinja2
#RUN apt-get -y install debhelper-compat flex bison libssl-dev libelf-dev kernel-wedge pkg-config liblz4-tool tmux libncurses5-dev libcap-dev gawk gcc-13 dkms pahole cpio libdwarf-dev libdw-dev rustc rust-src bindgen rustfmt rust-clippy bc
RUN apt-get clean

RUN mkdir -p /home/${USERNAME}/.ssh \
    && mkdir -p /home/${USERNAME}/.gnupg \
    && chmod 700 /home/${USERNAME}/.ssh \
    && chmod 700 /home/${USERNAME}/.gnupg

RUN mkdir -p /source \
    && chown -R $USERNAME:$USERNAME /source

USER $USERNAME

RUN git config --global user.email "binli@ubuntu.com"
RUN git config --global user.name "Bin Li"
ENV DEBEMAIL="binli@ubuntu.com"
ENV DEBFULLNAME="Bin Li"
ENV USER="binli"

VOLUME /home/${USERNAME}/.ssh
VOLUME /home/${USERNAME}/.gnupg
VOLUME /source
WORKDIR /source
CMD ["bash"]
