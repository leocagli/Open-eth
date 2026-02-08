# Security Updates

## Overview

This document tracks security vulnerabilities and their resolutions in the Open-eth project.

## Fixed Vulnerabilities

### 2026-02-08: Next.js Security Updates

**Affected Package:** `next@14.0.0`

**Updated To:** `next@14.2.35`

**Vulnerabilities Fixed:**

1. **Next.js HTTP request deserialization DoS** (CVE-TBD)
   - Affected versions: >= 13.0.0, < 15.0.8
   - Severity: High
   - Description: HTTP request deserialization can lead to DoS when using insecure React Server Components
   - Fixed in: 14.2.35

2. **Denial of Service with Server Components - Incomplete Fix Follow-Up**
   - Affected versions: >= 13.3.1-canary.0, < 14.2.35
   - Severity: High
   - Description: DoS vulnerability in Server Components with incomplete fix
   - Fixed in: 14.2.35

3. **Denial of Service with Server Components**
   - Affected versions: >= 13.3.0, < 14.2.34
   - Severity: High
   - Description: Vulnerability to DoS attacks with Server Components
   - Fixed in: 14.2.35

4. **Next.js Authorization Bypass Vulnerability**
   - Affected versions: >= 9.5.5, < 14.2.15
   - Severity: Critical
   - Description: Authorization bypass in Next.js middleware
   - Fixed in: 14.2.35

5. **Next.js Cache Poisoning**
   - Affected versions: >= 14.0.0, < 14.2.10
   - Severity: Medium
   - Description: Cache poisoning vulnerability
   - Fixed in: 14.2.35

6. **Server-Side Request Forgery in Server Actions**
   - Affected versions: >= 13.4.0, < 14.1.1
   - Severity: High
   - Description: SSRF vulnerability in Server Actions
   - Fixed in: 14.2.35

7. **Authorization Bypass in Next.js Middleware**
   - Affected versions: >= 14.0.0, < 14.2.25
   - Severity: Critical
   - Description: Multiple authorization bypass issues in middleware
   - Fixed in: 14.2.35

**Actions Taken:**
- Updated `next` from `14.0.0` to `14.2.35`
- Updated `eslint-config-next` from `14.0.0` to `14.2.35`
- Verified all security patches are applied
- All vulnerabilities resolved

**Recommendation:**
Keep Next.js updated to the latest stable version to ensure all security patches are applied.

## Security Best Practices

### Dependency Management

1. **Regular Updates**
   - Check for updates weekly: `pnpm outdated`
   - Review security advisories regularly
   - Update dependencies with security patches immediately

2. **Security Scanning**
   - Run `pnpm audit` regularly
   - Use GitHub Dependabot for automated alerts
   - Review and act on security advisories

3. **Version Pinning**
   - Use exact versions for critical dependencies
   - Test updates in development before production
   - Document security-related version changes

### Development Security

1. **Environment Variables**
   - Never commit secrets to git
   - Use `.env.example` as template
   - Keep `.env` files in `.gitignore`

2. **Smart Contract Security**
   - Use OpenZeppelin audited contracts
   - Follow security best practices
   - Conduct security audits before mainnet deployment

3. **Code Review**
   - Review all dependencies before adding
   - Check for known vulnerabilities
   - Use security linters and scanners

## Reporting Security Issues

If you discover a security vulnerability in this project:

1. **DO NOT** create a public GitHub issue
2. Email the maintainers privately (if contact available)
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if available)

## Security Checklist

Before deploying to production:

- [ ] All dependencies are up to date
- [ ] No known vulnerabilities in dependencies
- [ ] Environment variables are secure
- [ ] Smart contracts audited (if applicable)
- [ ] Security best practices followed
- [ ] Access controls properly configured
- [ ] Error handling doesn't leak sensitive info
- [ ] HTTPS/TLS enabled
- [ ] Rate limiting configured
- [ ] Input validation in place

## Update History

| Date | Package | From | To | Reason |
|------|---------|------|-----|--------|
| 2026-02-08 | next | 14.0.0 | 14.2.35 | Multiple critical security vulnerabilities |
| 2026-02-08 | eslint-config-next | 14.0.0 | 14.2.35 | Compatibility with Next.js update |

## Resources

- [Next.js Security Documentation](https://nextjs.org/docs/app/building-your-application/deploying/production-checklist#security)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Web3 Security Best Practices](https://consensys.github.io/smart-contract-best-practices/)
- [GitHub Advisory Database](https://github.com/advisories)

## Maintenance

This document should be updated:
- When security vulnerabilities are discovered
- When security updates are applied
- When security best practices change
- At least quarterly for review

Last reviewed: 2026-02-08
