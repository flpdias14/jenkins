FROM debian:buster
LABEL maintainer="Uname Research Group <flpdias14@gmail.com>"
LABEL description="Based on Public Knowledge Project <marc.bria@gmail.com>"

# Basic packages
ENV PACKAGES \
        default-jdk 
    
ENV BUILDERS \
        wget \
        ca-certificates 
       

RUN apt update -y && apt upgrade -y

RUN apt install ${PACKAGES} -y

RUN  apt install ${BUILDERS} -y 

RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -

RUN sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

RUN apt update -y && apt install jenkins

RUN systemctl enable --now jenkins

RUN apt-get purge -y --auto-remove ${BUILDERS} \
        && apt-get autoremove -y \
        && rm -rf $(cat /tmp/exclude.list) \
        && rm -rf /tmp/* 



EXPOSE 8080 


