# Common Tools for SSL/TLS deployment

This is a common tools storage for storing various scripts useful for checking and validating [SSLLabs Guide](https://github.com/ssllabs/research/wiki/SSL-and-TLS-Deployment-Best-Practices) for best SSL/TLS practices.

## Quick Links

[Qualys SSL Labs](https://www.ssllabs.com)

[Security Headers](https://www.securityheaders.com)

## Security Headers

Mandate based on HTTPS and HSTS: https://https.cio.gov/

- Initial connection on HTTPS must have HSTS enabled.

## Protocols and Ciphers used

- Stop using TLS 1.0 and below (SSL 3.0 and below).
- Use A rated ciphers based on nmap results.

## IPv4 and IPv6 check

- Ensure connectivity for IPv6 is reachable.
