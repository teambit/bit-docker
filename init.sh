#!/bin/bash
set -x
if [ $DEVELOPMENT = true ]; then
    npm uninstall -g bit-bin
    ln -sf $BITPATH/bin/bit.js /usr/local/bin/bit
else
    apt-get update
    npm install -g bit-bin
fi

cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys 

bit init --bare

/usr/sbin/sshd -D