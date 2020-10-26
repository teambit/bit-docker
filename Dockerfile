# Setup container
FROM node:current-slim

# Install ssh and bit dependencies
RUN apt-get update 
RUN apt-get upgrade -y 
RUN apt-get install -y  apt-transport-https gcc make python g++
RUN apt-get install git -y 

# Install Bit-harmony
RUN yarn global add @teambit/bit --unsafe-perm=true
RUN ln -s /usr/local/bin/bbit /usr/local/bin/bit

# config bit analytics
RUN bit config set analytics_reporting false
RUN bit config set error_reporting false
RUN bit config set no_warnings true

# Set working directory
RUN mkdir /tmp/scope
WORKDIR /tmp/scope

# Setting up scope
ADD init.sh .
RUN chmod +x init.sh
ADD scope.jsonc .
ADD scope.json .

# Run server
EXPOSE 3000
CMD ["/tmp/scope/init.sh"]