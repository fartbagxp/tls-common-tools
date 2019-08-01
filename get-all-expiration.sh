#!/usr/bin/env bash

#########################################################################################
# This script is created to run through all certificate expirations.
#
# Usage example: bash get-all-expiration.sh va.gov
#########################################################################################

if [ -z "$1" ]
then
  echo "Usage: bash get-all-expiration.sh <website>"
  exit 1
fi

name="$1"

print_all_certs() {
  echo ${1}
  curl https://pulse.cio.gov/data/hosts/${1}/https.csv -o ${1}.csv
  readarray -t domains < <(cut -d, -f1 ${1}.csv)

  for i in "${domains[@]}"
  do 
    temp="${i%\"}"
    temp="${temp#\"}"
    bash cert-expiration.sh ${temp}
  done
}

print_all_certs ${name}