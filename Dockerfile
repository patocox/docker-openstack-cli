FROM ubuntu:14.04
MAINTAINER CenturyLinkLabs

RUN apt-get -qqy update && \
 apt-get -qqy install git nodejs npm && \
 ln -s /usr/bin/nodejs /usr/bin/node

#Install Wetty
RUN git clone https://github.com/krishnasrinivas/wetty.git
WORKDIR /wetty
RUN npm install && \
 apt-get install -y vim && \
 useradd -d /home/term -m -s /bin/bash term && \
 echo 'term:term' | chpasswd

#Install CLIs
RUN apt-get update && \
 apt-get install -y python-software-properties

RUN apt-get update && \
 apt-get install -y python-keystoneclient && \
 apt-get install -y python-swiftclient && \
 apt-get install -y python-novaclient && \
 apt-get install -y python-troveclient && \
 apt-get install -y python-glanceclient && \
 apt-get install -y python-cinderclient && \
 apt-get install -y python-heatclient && \
 apt-get install -y python-ceilometerclient && \
 apt-get install -y python-neutronclient

ADD config /tmp/config
RUN chmod +x /tmp/config

EXPOSE 3000

CMD ["bash","/tmp/config"]
