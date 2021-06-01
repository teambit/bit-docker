#!/bin/bash
set -x
apt-get update
yarn global add @teambit/bit

bit init --bare

bit start
