#!/usr/bin/env bash

#########################################################################################
# This script is created to automate the checking of public facing DNS results for a
# particular website. Some sites have round-robin configurations for 
#
# Usage example: bash external-ips.sh va.gov
#########################################################################################

CURRENT_PUBLIC_IP=""
DEFAULT_WAIT_TIME_IN_SEC=30
WAIT_TIME_IN_SEC=$DEFAULT_WAIT_TIME_IN_SEC
NUM_TIMES_IP_SEEN=1

while true
do
  PUBLIC_IP="$(dig +short va.gov)"

  # if the same IP is found, keep waiting and add x sec to timer
  # otherwise print the new IP address and restart wait timer
  if [[ $CURRENT_PUBLIC_IP == $PUBLIC_IP ]]; then
    WAIT_TIME_IN_SEC=$((DEFAULT_WAIT_TIME_IN_SEC*NUM_TIMES_IP_SEEN))
  else
    echo "Waited ${WAIT_TIME_IN_SEC} seconds for new IP address."
    echo New IP address: "${PUBLIC_IP}"
    CURRENT_PUBLIC_IP=${PUBLIC_IP}
    NUM_TIMES_IP_SEEN=1
    DATE=`date +%Y-%m-%d`
  fi

  sleep ${WAIT_TIME_IN_SEC}
done