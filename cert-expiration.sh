#!/usr/bin/env bash

# TODO: notify automatically for certificate expiration

TOP_LEVEL_DOMAIN=$1
# curl -s https://certspotter.com/api/v0/certs?domain=${TOP_LEVEL_DOMAIN} | jq .[].issuer | sort | uniq -c | sort -rn

# curl -s https://certspotter.com/api/v0/certs?domain=${TOP_LEVEL_DOMAIN} | jq '.[] | {dns_names,issuer,not_before,not_after}'
# curl -s https://certspotter.com/api/v0/certs?domain=${TOP_LEVEL_DOMAIN} | jq -s -c '.[] | sort_by(.not_after)' | jq '[.[] | {dns_names,issuer,not_before,not_after}]'

#cat test.json | jq -s -c '.[] | sort_by(.not_after)' | jq '[.[] | {issuer,not_before,not_after}]' | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv'

# cat test.json | jq -s -c '.[] | sort_by(.not_after)' | jq '[.[] | {dns_names: .dns_names | join("|"), issuer: .issuer, not_before: .not_before, not_after: .not_after}]' | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv'

# {id: .id, hashtags: .hashtags | join(";")}
# {"code":"rate_limited","message":"You have exceeded the domain search rate limit for the Cert Spotter API.  Please try again later, or authenticate with an API key."}

FIRST_RESULT=$(curl "https://api.certspotter.com/v1/issuances?domain=${TOP_LEVEL_DOMAIN}&include_subdomains=true&expand=dns_names&expand=issuer&expand=cert")

# while result is not nil
# keep curl with &after= parameter

