# FROM node:current

# WORKDIR /bit-bin

# RUN apt-get update || : && apt-get install python -y

# RUN npm i -g @teambit/bit --unsafe-perm=true

# EXPOSE 8080
# CMD [ "bbit", "init --bare" ]



FROM node:current-slim

ENV DEVELOPMENT=false
ENV BITPATH=/bit-bin

#Install ssh and bit dependencies
RUN apt-get update 
RUN apt-get upgrade -y 
RUN apt-get install -y vim nano openssh-server curl && mkdir /var/run/sshd
RUN apt-get install -y  apt-transport-https gcc make python g++
RUN apt-get install git -y 

# Install latest (stable) Bit version
RUN yarn global add @teambit/bit --unsafe-perm=true
RUN bbit config set analytics_reporting false
RUN bbit config set error_reporting false
RUN bbit config set no_warnings true
RUN mkdir -p /root/.ssh
RUN mkdir /tmp/scope
WORKDIR /tmp/scope
ADD init.sh .
RUN chmod +x init.sh

EXPOSE 22
CMD  ["/tmp/scope/init.sh"]