#!/bin/bash
set -x
if [ $DEVELOPMENT = true ]; then
    ln -sf $BITPATH/bin/bit.js /usr/local/bin/bit
else
    apt-get update
    apt-get install bit -y
fi

bit init --bare

node /ssh/index.js