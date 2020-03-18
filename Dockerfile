FROM ubuntu:18.04

ADD https://download.foldingathome.org/releases/public/release/fahcontrol/debian-stable-64bit/v7.5/fahcontrol_7.5.1-1_all.deb ./
ADD https://download.foldingathome.org/releases/public/release/fahviewer/debian-stable-64bit/v7.5/fahviewer_7.5.1_amd64.deb ./
RUN apt update && apt install python python-gnome2 dh-python ./fahcontrol_7.5.1-1_all.deb ./fahviewer_7.5.1_amd64.deb -y

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/fah && \
    echo "fah:x:${uid}:${gid}:FAH,,,:/home/fah:/bin/bash" >> /etc/passwd && \
    echo "fah:x:${uid}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d/ && \
    echo "fah ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/fah && \
    chmod 0440 /etc/sudoers.d/fah && \
    chown ${uid}:${gid} -R /home/fah

USER fah
ENV HOME /home/fah
CMD /usr/bin/FAHControl