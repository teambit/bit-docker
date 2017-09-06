Bit: Write code once, use it anywhere. [![Release](https://circleci.com/gh/teambit/bit/tree/master.svg?style=shield&circle-token=d9fc5b19b90fb7e0655d941a5d7f21b61174c4e7)](https://bitsrc.io)
============================

Bit is a distributed code component manager.

**Increase reusability:** Designed for fast and easy extraction and reuse of code
components without creating duplications or publishing packages..

**Simply and predictable:** Bit uses features such as simple inline editing,
strict minor versioning and test based updating to make modifying and maintaining
is super simple.

**Discoverable:** Bit uses a functionality-based search and a simple yet smart
scoping mechanism to easily find and reuse components created by you or by others.


Getting started
===============

Create a virtual set of reusable code components to be used as building blocks across your repositories and applications. To get started, [check out the installation.instructions in the
documentation](https://teambit.github.io/bit/installation.html).


Run remote scope with latest bit version:
=================================

`docker run --rm --name bit -d -P  --volume ~/.ssh/id_rsa.pub:/tmp/id_rsa.pub bitteam/bit-docker`

`bit remote add ssh://root@localhost:<port>:/tmp/scope -g`

developing bit and testing:
===========================

`docker run --rm --name bit -d -P  --volume <path to bit code>:/bit-bin  --volume ~/.ssh/id_rsa.pub:/tmp/id_rsa.pub --env 'DEVELOPMENT=true' bitteam/bit-docker`

Get working port of docker container:
=====================================
`docker port bit 22`

Then use port to add remote scope

Advance use of the container:
=====================================
In the following commands you should replace container-id with bit (which is the name of the container)

### Run bash on the container
`docker exec -it <container-id> /bin/bash`

### Copy your own ssh key to the container

relevant in case when you are going to export a component which need to resolve the dependencies against private scopes in the hub

Copy your ssh key into the container (from outside bash)

`docker cp ~/.ssh/id_rsa <container id>:/root/.ssh/`

on the container bash:

`bit config ssh_key_file /root/.ssh/id_rsa`

### Show bit logs on the container

`tail -f /root/Library/Caches/Bit/logs/debug.log`
      

Kill container
==============

`docker kill bit`

Build image:
============

`docker build . -t bit`
    
