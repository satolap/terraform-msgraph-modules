# GraphModules

Tested Terraform modules for Microsoft Graph v1.0 and beta, with a curated set
of modules for common directory and entitlement-management scenarios.

Browse the [v1.0 catalog](generated/v1.0/README.md),
[beta catalog](generated/beta/README.md), or [curated modules](modules).
Each [release](https://github.com/benhaspalace/GraphModules/releases) includes
the three module archives, an input provenance manifest, and SHA256 checksums.

## Use a module

Pin a published release tag for repeatable deployments:

```hcl
module "application" {
  source       = "git::https://github.com/benhaspalace/GraphModules.git//generated/v1.0/applications/applications?ref=<release-tag>"
  display_name = "Example application"
}

module "curated_group" {
  source           = "git::https://github.com/benhaspalace/GraphModules.git//modules/groups?ref=<release-tag>"
  display_name     = "Example group"
  mail_nickname    = "example-group"
  security_enabled = true
}
```

Replace `<release-tag>` with a tag from
[Releases](https://github.com/benhaspalace/GraphModules/releases) and configure
the [`microsoft/msgraph`](https://registry.terraform.io/providers/microsoft/msgraph/latest/docs)
provider in the calling root module. Generated modules follow the Microsoft
Graph schemas recorded in that release. Beta modules retain Microsoft Graph's
preview limitations and can change incompatibly between releases.

## Provenance and licensing

Every release records the exact upstream revisions and checksums used to build
the module catalogs in `generated/release-manifest.json` and in the downloadable
`release-manifest.json` asset.

The original project code and curated modules are available under the
[MIT License](LICENSE). Generated schema descriptions and module interfaces are
derived from [Microsoft Graph metadata](https://github.com/microsoftgraph/msgraph-metadata),
which Microsoft publishes under the MIT License. Catalog categories and resource
links are adapted from the
[Microsoft Graph documentation](https://github.com/microsoftgraph/microsoft-graph-docs-contrib),
which is licensed under Creative Commons Attribution 4.0. See [NOTICE](NOTICE)
for the applicable upstream notices and license details.

Microsoft Graph and related names may be trademarks of Microsoft Corporation.
This independent project is not affiliated with or endorsed by Microsoft.

## Community

See [CONTRIBUTING.md](CONTRIBUTING.md) before proposing a change. Participation
is governed by the [Code of Conduct](CODE_OF_CONDUCT.md), and vulnerabilities
should be reported according to [SECURITY.md](SECURITY.md).
