FROM node


RUN apt-get update
RUN apt-get install -y curl python-software-properties software-properties-common apt-transport-https gcc make python g++
RUN curl https://bitsrc.jfrog.io/bitsrc/api/gpg/key/public | apt-key add -
RUN sh -c "echo 'deb http://bitsrc.jfrog.io/bitsrc/bit-deb all stable' >> /etc/apt/sources.list"


RUN mkdir /root/.ssh
RUN mkdir /scope
RUN mkdir /ssh
WORKDIR /ssh
ADD index.js .
ADD package.json  .
RUN npm i
ENV BITPATH=/bit-bin
ENV DEVELOPMENT=false

# Server key
ENV PRIVATE_KEY=id_rsa 
ENV PUBLIC_KEY=id_rsa.pub

WORKDIR /scope
ADD init.sh  .
RUN chmod +x init.sh
EXPOSE 3000
CMD /bin/bash init.sh