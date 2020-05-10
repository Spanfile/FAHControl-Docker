FROM ubuntu:18.04

ADD https://download.foldingathome.org/releases/public/release/fahcontrol/debian-stable-64bit/v7.6/latest.deb ./fahcontrol.deb
ADD https://download.foldingathome.org/releases/public/release/fahviewer/debian-stable-64bit/v7.6/latest.deb ./fahviewer.deb
RUN apt update && apt install python python-gnome2 dh-python ./fahcontrol.deb ./fahviewer.deb -y

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
