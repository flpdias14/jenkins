FROM debian:buster
LABEL maintainer="Uname Research Group <flpdias14@gmail.com>"
LABEL description="jenkins docker file"

# Basic packages
ENV PACKAGES \
        default-jdk 
    
ENV BUILDERS \
        wget \
        gnupg2
       

RUN apt update -y && apt upgrade -y

RUN apt install ${PACKAGES} -y

RUN  apt install ${BUILDERS} -y 

RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -

RUN sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

RUN apt update -y && apt install jenkins -y

RUN systemctl enable --now jenkins 

RUN /etc/init.d/jenkins start

RUN apt-get purge -y --auto-remove ${BUILDERS} \
        && apt-get autoremove -y \
        && rm -rf $(cat /tmp/exclude.list) \
        && rm -rf /tmp/* 

COPY entrypoint.sh /sbin/entrypoint.sh

WORKDIR /sbin

RUN chmod 755 entrypoint.sh 


EXPOSE 8080 
