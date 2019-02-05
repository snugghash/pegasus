#!/bin/bash

# Copyright 2015 Insight Data Science
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# first argument is the brokerid and all after are MASTER_DNS and SLAVE_DNS
ID=$1; shift
PUBLIC_DNS=$1; shift
DNS=( "$@" )

. ~/.profile

sudo sed -i 's@broker.id=0@broker.id='"$ID"'@g' /usr/local/kafka/config/server.properties
sudo sed -i 's@#advertised.listeners=PLAINTEXT://your.host.name@advertised.listeners=PLAINTEXT://'"$PUBLIC_DNS"'@g' /usr/local/kafka/config/server.properties

sudo sed -i '1i export JMX_PORT=${JMX_PORT:-9999}' /usr/local/kafka/bin/kafka-server-start.sh

ZK_SERVERS=""
for dns in ${DNS[@]}
do
    ZK_SERVERS=$ZK_SERVERS$dns:2181,
done

sudo sed -i 's@localhost:2181@'"${ZK_SERVERS:0:-1}"'@g' /usr/local/kafka/config/server.properties

# Install Pyenv, for py3.7
curl https://pyenv.run | bash
# Update path
echo 'export PATH="/home/ubuntu/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
source ~/.bashrc
# Get personal github onto the thing, run personal setup script
git clone https://github.com/snugghash/homomorphically-encrypted-bank
cd ~/homomorphically-encrypted-bank/src/data-source/ETH-blockchain/
sudo apt-get install --yes --force-yes\
	python3\
	python3-pip\
	zlibc
pip3 install pipenv
pipenv install
