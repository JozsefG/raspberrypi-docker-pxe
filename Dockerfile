FROM resin/rpi-raspbian:latest
MAINTAINER "demon1ak ifj.gyorijozsef@gmail.com"

RUN apt-get update 

RUN apt-get install -y syslinux-dev dnsmasq

RUN mkdir /srv/tftpboot 

RUN cp /usr/lib/syslinux/pxelinux.0 /srv/tftpboot 

ADD resources/menu.c32 /srv/tftpboot/
RUN chmod 755 /srv/tftpboot/menu.c32

RUN mkdir /srv/tftpboot/pxelinux.cfg
ADD resources/default /srv/tftpboot/prelinux.cfg/
RUN chmod 755 /srv/tftpboot/prelinux.cfg/default

ADD resources/dnsmasq.conf /root/
RUN chmod 755 /root/dnsmasq.conf

RUN cat /root/dnsmasq.conf >> /etc/dnsmasq.conf
RUN echo 'user=root' >> /etc/dnsmasq.conf


RUN service dnsmasq start


