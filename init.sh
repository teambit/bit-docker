#!/bin/bash
set -x
apt-get update
yarn install -g bit-bin

bit init --bare

bit start