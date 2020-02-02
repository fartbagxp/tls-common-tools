#!/usr/bin/env bash

#########################################################################################
# This script is created to list out all the protocols and ciphers used for TLS/SSL.
#
# Usage example: bash cipher-check.sh https://www.va.gov
#########################################################################################

if ! type openssl >/dev/null 2>&1; then
  echo "openssl is not installed. Must have openssl to proceed." 
  exit 1
fi

if ! type nmap >/dev/null 2>&1; then
  echo "nmap is not installed. Must have nmap to proceed." 
  exit 1
fi

SERVER=$1
if [ $# != 1 ]; then
  echo "Usage: $0 <server-to-check>"
  exit
fi;

if [[ "${SERVER}" != "https://"* ]]; then
  echo "Usage: $0 <server-to-check> must start with https://"
  exit
fi;

DELAY=1
ciphers=$(openssl ciphers 'ALL:eNULL' | sed -e 's/:/ /g')

# Alternative way using nmap:
FQDN_SERVER=${SERVER#*//}
nmap --script ssl-enum-ciphers -p 443 "$FQDN_SERVER"