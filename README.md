# Purpose

This repo holds a set of common tools and simple scripts for checking and validating [SSLLabs Guide](https://github.com/ssllabs/research/wiki/SSL-and-TLS-Deployment-Best-Practices) for best SSL/TLS practices.

It is meant to provide an independent audit for a particular site in compliance of [White House Office of Management and Budget memorandum M-15-13](https://https.cio.gov/) as well as [Department of Homeland Security binding Operational Directive 18-01](https://cyber.dhs.gov/bod/18-01/) manually and automatically.

The goal is to be able to reproduce results of the [pulse.cio.gov portal](https://pulse.cio.gov/https/domains/) manually and automatically.

## Common audit questions to answer

- What IP address(es) is the web server hosted on?
- Does the website support IPv6 connectivity?
- Does the web server should support port 80 and port 443?
- Does the website on port 80 redirect to port 443 on initial connection?
- Does the initial connection to port 443 support HSTS - `Strict-Transport-Security: max-age=31536000; includeSubDomains; preload`?
- Does subsequent redirection after the initial connection support HSTS - `Strict-Transport-Security: max-age=31536000; includeSubDomains; preload`?
- How are the SSL cipher, protocol, and key exchange rated based on [ssllabs cipher rating guide](https://github.com/ssllabs/research/wiki/SSL-Server-Rating-Guide)?
- When will the SSL certificate expire?
- What are some of the upcoming subdomains in the same zone and top level domain with expiring SSL certificates?

## How to use

## Quick links

[Qualys SSL Labs](https://www.ssllabs.com)

[Quick checks for Https Security Headers](https://www.securityheaders.com)

## Quick reading

[Mandate to stop using TLS 1.0 and older ciphers (SSL 3.0 and below)](https://www.nist.gov/oism/tls-10-being-turned-wwwnistgov)

[Difference between DHS 18-01 mandate and OMB 15-13](https://cyber.dhs.gov/bod/18-01/#how-does-the-web-security-requirement-in-bod-18-01-differ-from-m-15-13)
