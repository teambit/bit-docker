# Bit-Remote-Scope - https://bitsrc.io
Remote bit scope to test and develop bit

Requirments: 
  1. attach ssh keys to container 


###DEVELOPMENT:
    docker run --rm --name bit -p 3000:3000  --volume <path to bit code>:/bit-bin  --volume ~/.ssh:/root/.ssh --env 'DEVELOPMENT=true'  teambit/bit

###Remote scope with latest stabel version: 
    docker run --rm --name bit -p 3000:3000 --volume ~/.ssh:/root/.ssh teambit/bit
      

### add remote scope from workspace 

    bit remote add ssh://root@localhost:3000:/scope
