FROM alpine:latest

RUN apk add --no-cache \
    bind \ 
    curl \
    dhcp-server \
    git \
    go \
    python3 \
    py3-pip \
    tftp-hpa \ 
    sudo


RUN ln -s /usr/bin/python3 /usr/bin/python && \
    adduser -D netauto && \
    adduser netauto wheel && \
    echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "export PATH=$PATH:~/.local/bin" > /etc/profile.d/fixpath.sh

USER netauto
WORKDIR /home/netauto

ADD requirements.txt ./

# should I seperate into seperate venvs...makes the image larger and maybe a bit harder to use...

RUN pip install -r requirements.txt


CMD sh --login