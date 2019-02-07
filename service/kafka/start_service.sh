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

PEG_ROOT=$(dirname ${BASH_SOURCE})/../..
source ${PEG_ROOT}/util.sh

if [ "$#" -ne 1 ]; then
    echo "Please specify cluster name!" && exit 1
fi

CLUSTER_NAME=$1

PUBLIC_DNS=$(fetch_cluster_public_dns ${CLUSTER_NAME})

cmd='sudo /usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties &'
# Start kafka broker on all nodes
for dns in ${PUBLIC_DNS}; do
  echo $dns
  run_cmd_on_node ${dns} ${cmd} &
done

wait

echo "Kafka Started!"

# Create kafka topics
kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic eth-old
kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic eth-encrypted
kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic eth-subtracted
kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic eth-decrypted

cd ~/homomorphically-encrypted-bank/src/data-source/ETH-blockchain/
pipenv run python kafka-producer.py \
	 && echo "Started producer from BigQuery!"
