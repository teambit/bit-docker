FROM ubuntu


ENV  DEVELOPMENT=false
ENV BITPATH=/bit-bin
RUN apt-get update 
RUN apt-get upgrade -y 
RUN apt-get install -y openssh-server curl && mkdir /var/run/sshd
RUN apt-get install -y  apt-transport-https gcc make python g++

RUN curl https://bitsrc.jfrog.io/bitsrc/api/gpg/key/public |  apt-key add -
RUN sh -c "echo 'deb http://bitsrc.jfrog.io/bitsrc/bit-deb all stable' >> /etc/apt/sources.list"
RUN mkdir -p /root/.ssh
RUN mkdir /tmp/scope
WORKDIR /tmp/scope
ADD init.sh .
RUN chmod +x init.sh

RUN apt-get update
RUN apt-get install bit -y
EXPOSE 22
CMD  ["/tmp/scope/init.sh"]