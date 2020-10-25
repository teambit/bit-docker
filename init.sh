#!/bin/bash
set -x
if [ $DEVELOPMENT = true ]; then
    npm uninstall -g @teambit/bit
    ln -sf $BITPATH/bin/bit.js /usr/local/bin/bit
else
    apt-get update
    yarn global add @teambit/bit
fi

cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys 

bbit init --bare && bbit start

/usr/sbin/sshd -D