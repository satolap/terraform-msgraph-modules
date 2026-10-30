# Security policy

## Supported versions

Security fixes are applied to the latest published release and the current `main`
branch. Older release tags are immutable and are not updated in place. Users should
upgrade to the latest release after a fix is published.

## Reporting a vulnerability

Please do not disclose a suspected vulnerability in a public issue, discussion,
pull request, or log. Report it privately through GitHub's private vulnerability
reporting: [Report a vulnerability](https://github.com/satolap/terraform-msgraph-modules/security/advisories/new)
(Security > Report a vulnerability).

Include the affected release tag and module path, the potential impact, reproduction
steps, and any suggested mitigation in the private report. Remove credentials,
access tokens, tenant data, and personal information from all supporting material.

You can expect an initial acknowledgement within seven days. Maintainers will
coordinate validation, remediation, and disclosure timing with the reporter. Please
allow a reasonable period for a fix before public disclosure.

For vulnerabilities in Microsoft Graph, the `microsoft/msgraph` provider, Terraform,
or another dependency, report the issue to that upstream project's security channel.
