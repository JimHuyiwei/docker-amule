FROM amd64/debian:buster

RUN cat /dev/null > /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/debian/ buster main non-free contrib" > /etc/apt/sources.list

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

ADD amule-daemon_2.3.2-5_amd64.deb /tmp

RUN dpkg -i /tmp/amule-daemon_2.3.2-5_amd64.deb && rm /tmp/amule-daemon_2.3.2-5_amd64.deb

# volumes and ports
VOLUME /config /downloads
EXPOSE 4711/tcp 4712/tcp 4672/udp 4665/udp 4662/tcp 4661/tcp 

ENTRYPOINT /usr/bin/amuled
CMD -c /config

