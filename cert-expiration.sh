#!/usr/bin/env bash

#########################################################################################
# This script checks the certificate expiration date for a host and was taken from 
# https://stackoverflow.com/a/47878528.
#
# Usage example: bash cert-expiration.sh va.gov
#########################################################################################
if [ -z "$1" ]
then
  echo "Usage: bash cert-expiration.sh <website>"
  exit 1
fi

name="$1"
shift

now_epoch=$( date +%s )

dig +noall +answer "$name" | while read -r _ _ _ _ ip;
do
  echo -n "$name,$ip,"
  expiry_date=$( echo | timeout 3 openssl s_client -showcerts -servername "$name" -connect "$ip":443 2>/dev/null | openssl x509 -inform pem -noout -enddate | cut -d "=" -f 2 )
  echo -n "$expiry_date,";
  expiry_epoch=$( date -d "$expiry_date" +%s )
  expiry_days="$(( (expiry_epoch - now_epoch) / (3600 * 24) ))"
  expiry_time="$(( expiry_epoch - now_epoch )) "
  echo -n "$expiry_days days,"
  echo "$expiry_time"
done
