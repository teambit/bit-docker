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

    docker run --rm --name bit -d -P  --volume ~/.ssh/id_rsa.pub:/tmp/id_rsa.pub <image name>


developing bit and testing:
===========================

    docker run --rm --name bit -d -P  --volume <path to bit code>:/bit-bin  --volume ~/.ssh/id_rsa.pub:/tmp/id_rsa.pub --env 'DEVELOPMENT=true'  <image name>


Get working port of docker container:
=====================================
    docker port bit 22

Then use port to add remote scope

    bit remote add ssh://root@localhost:<port>:/tmp/scope -g
      
    
