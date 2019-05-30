#!/usr/bin/env bash

#########################################################################################
# This script is created to automate the checking of security headers for various sites
# under guidelines of OMB-15-13: https://https.cio.gov/guide/#options-for-hsts-compliance.
# It is meant to be modified to be something more powerful if needed and serves as a 
# template for future scripts.
#
# Usage example: bash security-headers.sh https://www.va.gov
#########################################################################################

WEBSITE=$1
EXPECTED_VALUE="Strict-Transport-Security: max-age=31536000; includeSubDomains; preload"
if [ $# != 1 ]; then
  echo "Usage: $0 <website-to-check>"
  exit
fi;

if [[ "${WEBSITE}" != "https://"* ]]; then
  echo "Usage: $0 <website-to-check> must start with https://"
  exit
fi;

HTTPS="https://"
SITE_URL=${WEBSITE#"$HTTPS"}
DNS_RESULT=$(dig +short ${SITE_URL})
echo "$WEBSITE resolves to $DNS_RESULT."

RESULTS=$(curl -sI --resolve ${WEBSITE}:443:${WEBSITE} ${WEBSITE} 2>&1 | grep -i strict-transport-security)
if [[ -z "${RESULTS// }" ]]; then
  echo Could not resolve "$WEBSITE".
  exit
fi

if [[ "${RESULTS}" != "${EXPECTED_VALUE}"* ]]; then
  echo was expecting: "${EXPECTED_VALUE}"
  echo instead got: "${RESULTS}"
else
  echo "$WEBSITE" supports HTTPS and proper HSTS.
fi;
