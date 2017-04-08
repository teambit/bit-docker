#!/bin/bash
set -x
if [ $DEVELOPMENT = true ]; then
    apt-get remove bit -y
    ln -sf $BITPATH/bin/bit.js /usr/local/bin/bit
else
    apt-get update
    apt-get install bit -y
fi

cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys 

bit init --bare

/usr/sbin/sshd -D