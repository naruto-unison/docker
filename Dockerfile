FROM debian:bullseye-slim
LABEL maintainer="Joshua Booth <joshua.n.booth@gmail.com>"

ARG PORT_WEB=80
ARG PORT_SSH=23

RUN  apt-get update && apt-get install sendmail m4 openssh-server -y

COPY keter-1.4.3.2     /opt/keter/bin/
COPY keter-config.yaml /opt/keter/bin/
RUN  mkdir             /opt/keter/incoming/

COPY sendmail.conf     /etc/mail/
RUN  /usr/share/sendmail/update_conf

RUN  echo "Port ${PORT_SSH}" >> /etc/ssh/sshd_config
RUN  /etc/init.d/ssh restart

EXPOSE ${PORT_WEB}
EXPOSE ${PORT_SSH}

CMD ["/opt/keter/bin/keter-1.4.3.2", "/opt/keter/bin/keter-config.yaml"]
