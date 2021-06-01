#!/bin/bash
set -x
apt-get update
yarn global add @teambit/bit

bbit init --bare

bbit start
