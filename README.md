# Common Tools for SSL/TLS deployment

This is a common tools storage for storing various scripts useful for checking and validating [SSLLabs Guide](https://github.com/ssllabs/research/wiki/SSL-and-TLS-Deployment-Best-Practices) for best SSL/TLS practices.

## Quick Links

[Technical Guidance on HTTPS/TLS/HSTS](https://https.cio.gov/)

[Qualys SSL Labs](https://www.ssllabs.com)

[Quick checks with Security Headers](https://www.securityheaders.com)

## Security Headers

- Initial connection on HTTPS must have HSTS enabled.

## Protocols and Ciphers used

- Stop using TLS 1.0 and below (SSL 3.0 and below).
- Use A rated ciphers based on nmap results.

## IPv4 and IPv6 check

- Ensure connectivity for IPv6 is reachable.

## Mandates

1. Presidental OMB Mandate M-15-13.
1. DHS binding Operational Directive 18-01.

## TIC Guidance

https://itmodernization.cio.gov/report/shared-services/
https://itmodernization.cio.gov/report/appendices/cloud-security-protections/
https://itmodernization.cio.gov/report/appendices/challenges-to-perimeter-security/
https://pulse.cio.gov/data/hosts/va.gov/https.csv
https://pulse.cio.gov/https/guidance/#subdomains
