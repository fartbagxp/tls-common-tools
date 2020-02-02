#!/usr/bin/env bash

#########################################################################################
# This script is created to automate the checking of public facing DNS results for a
# particular website. It will cycle through indefinitely to find all DNS entries 
# allocated to a host, where hosts's DNS resolver is utilizing round-robin configuration
# to point to multiple IP addresses. 
#
# Usage example: bash external-ips.sh va.gov
#########################################################################################

if ! type dig >/dev/null 2>&1; then
  echo "dig is not installed. Must have dig to proceed." 
  exit 1
fi

WEBSITE_HOST=$1
if [ $# != 1 ]; then
  echo "Usage: $0 <host-to-check>"
  exit
fi;

CURRENT_PUBLIC_IPV4=""
CURRENT_PUBLIC_IPV6=""
DEFAULT_WAIT_TIME_IN_SEC=30
WAIT_TIME_IN_SEC=$DEFAULT_WAIT_TIME_IN_SEC

while true
do
  RESULTS="$(dig +short AAAA "$WEBSITE_HOST" A "$WEBSITE_HOST" 2>&1)"
  IPV4=$(echo "${RESULTS}" | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
  IPV6=$(echo "${RESULTS}" | grep -E -o "(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))")

  # if the same IP is found, keep waiting and add x sec to timer
  # otherwise print the new IP address and restart wait timer
  if ! [[ $CURRENT_PUBLIC_IPV4 == "$IPV4" && "$CURRENT_PUBLIC_IPV6" == "$IPV6" ]]; then
    CURRENT_PUBLIC_IPV4="${IPV4}"
    CURRENT_PUBLIC_IPV6="${IPV6}"
    DATE=$(date +%x-%X)
    echo New IP address found:
    echo "$DATE"
    echo "  ${IPV4}"
    echo "  ${IPV6}"
  fi

  echo "Waiting ${WAIT_TIME_IN_SEC} seconds to check for new IP address(es)."
  sleep ${WAIT_TIME_IN_SEC}
done