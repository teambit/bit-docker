# Bit-Remote-Scope - https://bitsrc.io
Remote bit scope to test and develop bit

###INFO:

    Remote scope is created in path: /tmp/scope

###DEVELOPMENT:

    docker run --rm --name bit -d -P  --volume <path to bit code>:/bit-bin  --volume ~/.ssh/id_rsa.pub:/tmp/id_rsa.pub --env 'DEVELOPMENT=true'  <image name>

###Remote scope with latest stabel version: 

    docker run --rm --name bit -d -P  --volume ~/.ssh/id_rsa.pub:/tmp/id_rsa.pub <image name>


### RUN 
    docker port bit 22

Then use port to add remote scope

    bit remote add ssh://root@localhost:<port>:/tmp/scope
      
    
