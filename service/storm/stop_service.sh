#!/bin/bash

PEG_ROOT=$(dirname ${BASH_SOURCE})/../..
source ${PEG_ROOT}/util.sh

if [ "$#" -ne 1 ]; then
    echo "Please specify cluster name!" && exit 1
fi

CLUSTER_NAME=$1

MASTER_PUBLIC_DNS=$(get_public_dns_with_name_and_role ${CLUSTER_NAME} master)
WORKER_PUBLIC_DNS=$(get_public_dns_with_name_and_role ${CLUSTER_NAME} worker)

for dns in ${WORKER_PUBLIC_DNS}; do
  echo $dns
  cmd='tmux kill-session -t supervisor'
  run_cmd_on_node ${dns} ${cmd}
done

echo $MASTER_PUBLIC_DNS
cmd="tmux kill-session -t stormui; tmux kill-session -t nimbus"
run_cmd_on_node ${MASTER_PUBLIC_DNS} ${cmd}

echo "Storm Stopped!"
