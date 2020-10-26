#!/bin/bash
set -x
apt-get update
yarn install -g @teambit/bitß

bit init --bare

bit start