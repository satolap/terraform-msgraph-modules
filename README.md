# GraphModules

[![Release modules](https://github.com/benhaspalace/GraphModules/actions/workflows/release.yml/badge.svg)](https://github.com/benhaspalace/GraphModules/actions/workflows/release.yml)

GraphModules is a public catalog of tested, versioned **Terraform modules for
Microsoft Graph**. It helps manage **Microsoft Entra ID (formerly Azure Active
Directory, or Azure AD)** and **Microsoft 365** resources—including users,
groups, applications, service principals, and entitlement management—with
infrastructure as code through the
official [`microsoft/msgraph` Terraform provider](https://registry.terraform.io/providers/microsoft/msgraph/latest/docs).

The repository provides two complementary module collections:

- **Generated Microsoft Graph modules** cover supported create, read, update,
  and delete lifecycles from the Microsoft Graph v1.0 and beta schemas. They
  provide typed Terraform variables, request shaping, stable outputs, endpoint
  documentation, and credential-free mock tests.
- **Curated Microsoft Graph modules** handle common directory and identity
  governance scenarios that benefit from reviewed lifecycle behavior, including
  group membership, application and service-principal relationships, catalogs,
  access packages, assignment policies, and resource role scopes.

Pin a [published release](https://github.com/benhaspalace/GraphModules/releases)
to get an immutable module path and the exact metadata, provider versions, tests,
and checksums associated with it.

## Browse generated Microsoft Graph Terraform modules

Browse the **[Microsoft Graph v1.0 module catalog](modules/generated/v1.0/README.md)**
or the **[Microsoft Graph beta module catalog](modules/generated/beta/README.md)**.
The catalogs follow the service areas in the
[Microsoft Graph REST API reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true),
including Users, Groups, Applications, Identity and access, Mail, Calendars,
Teams, Files, Security, Devices, and other Microsoft 365 workloads.

Generated modules use this repository layout:

```text
modules/generated/<api-version>/<category>/<collection-path>/
```

Each endpoint appears once under its relevant service category. For example,
user messages appear under **Mail**, while group events appear under
**Calendars**. Category pages list the available Terraform modules and link each
one to its public Microsoft Graph resource documentation. Every module README
describes its inputs, outputs, Graph URL, lifecycle, permissions considerations,
schema limitations, import address, and offline test command.

Generation targets collection endpoints with a documented `POST` operation and
an item lifecycle that supports `GET`, `PATCH` or `PUT`, and `DELETE`. Actions,
functions, listing helpers, and unsupported transport patterns are outside this
generated CRUD subset. Review the endpoint README before use: Microsoft Graph
permissions, licensing, and tenant restrictions still apply.

Microsoft recommends v1.0 APIs for production applications. Microsoft Graph beta
APIs are previews and can change incompatibly; see Microsoft's
[versioning and support policy](https://learn.microsoft.com/en-us/graph/versioning-and-support).

## Use the curated Microsoft Graph Terraform modules

The curated modules focus on Microsoft Entra ID directory objects and entitlement
management workflows:

| Microsoft Graph area | Resource or workflow | Terraform module |
| --- | --- | --- |
| Users | `/users` | [`modules/curated/users`](modules/curated/users) |
| Groups | `/groups`, owners, and members | [`modules/curated/groups`](modules/curated/groups) |
| Applications | `/applications` | [`modules/curated/applications`](modules/curated/applications) |
| Applications | `/servicePrincipals` | [`modules/curated/service-principals`](modules/curated/service-principals) |
| Identity governance | Entitlement-management catalogs | [`modules/curated/identity-governance/entitlement-management/catalogs`](modules/curated/identity-governance/entitlement-management/catalogs) |
| Identity governance | Catalog resources | [`modules/curated/identity-governance/entitlement-management/catalogs/resources`](modules/curated/identity-governance/entitlement-management/catalogs/resources) |
| Identity governance | Access packages | [`modules/curated/identity-governance/entitlement-management/access-packages`](modules/curated/identity-governance/entitlement-management/access-packages) |
| Identity governance | Access-package resource role scopes | [`modules/curated/identity-governance/entitlement-management/access-packages/resource-role-scopes`](modules/curated/identity-governance/entitlement-management/access-packages/resource-role-scopes) |
| Identity governance | Assignment policies | [`modules/curated/identity-governance/entitlement-management/assignment-policies`](modules/curated/identity-governance/entitlement-management/assignment-policies) |

Curated modules expose higher-level Terraform inputs and outputs while preserving
Microsoft Graph identifiers for composition. Their READMEs document required
permissions, lifecycle choices, relationship cleanup, and module-specific examples.

## Install a module from GitHub

Configure the Microsoft Graph provider in the calling root module, then use a
Git source with a release tag:

```hcl
terraform {
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.4.0, < 1.0.0"
    }
  }
}

provider "msgraph" {}

module "application" {
  source       = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/applications/applications?ref=<release-tag>"
  display_name = "Example application"
}

module "engineering_group" {
  source           = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/groups?ref=<release-tag>"
  display_name     = "Engineering"
  mail_nickname    = "engineering"
  security_enabled = true
}
```

Replace `<release-tag>` with a `graphmodules-*` tag from
[Releases](https://github.com/benhaspalace/GraphModules/releases), then run
`terraform init`. HashiCorp documents the `git::` source, `//` subdirectory, and
`?ref=` tag syntax in
[Use modules in your configuration](https://developer.hashicorp.com/terraform/language/modules/configuration).
The provider supports Azure CLI, managed identity, service principal, and OpenID
Connect authentication; choose the method described in the
[`microsoft/msgraph` provider documentation](https://registry.terraform.io/providers/microsoft/msgraph/latest/docs).

## Module sources and provenance

The generated Terraform module interfaces come from public Microsoft sources:

- [Microsoft Graph metadata](https://github.com/microsoftgraph/msgraph-metadata)
  supplies OpenAPI and EDMX definitions for the v1.0 and beta endpoints. Microsoft
  explains how metadata represents Graph entity types, properties, enums, and
  relationships in [Calling the Microsoft Graph API](https://learn.microsoft.com/en-us/graph/call-api#microsoft-graph-api-metadata).
- [Microsoft Graph documentation](https://github.com/microsoftgraph/microsoft-graph-docs-contrib)
  supplies the public API-reference navigation used to organize modules by service
  area and link them to resource documentation.
- The official [`msgraph_resource`](https://registry.terraform.io/providers/microsoft/msgraph/latest/docs/resources/resource)
  implements the underlying Terraform lifecycle against Microsoft Graph REST APIs.

Each release pins immutable upstream commit IDs, source URLs, SHA-256 hashes,
provider versions, dependency hashes, and the complete input fingerprint. Inspect
[`modules/generated/release-manifest.json`](modules/generated/release-manifest.json)
or download the release's `release-manifest.json` asset to audit those inputs.
The catalogs do not fetch schemas or documentation during `terraform init`, plan,
or apply.

## Testing and release integrity

Every published catalog passes the following automated checks before its release
tag is created:

1. Source manifests and cached metadata are checked against their recorded
   revisions and SHA-256 hashes.
2. Python regression tests cover schema reconciliation, type generation,
   classification, deterministic output, safe archive handling, and atomic
   publication behavior.
3. `terraform fmt -check`, `terraform init -backend=false`, and
   `terraform validate` run for every generated module and every curated module
   against the exact provider versions recorded in the release manifest.
4. Credential-free `terraform test` suites use provider mocks to check Graph URL
   construction, typed request bodies, omission of null optional properties,
   validation failures, and curated relationship behavior without contacting a
   Microsoft Graph tenant.
5. The GraphModules release workflow rebuilds the v1.0, beta, and curated archives
   from the tagged commit and requires their byte-level SHA-256 checksums to match
   the already tested artifacts before publishing the GitHub Release.

Mock tests and schema validation do not prove that a caller has the required
Microsoft Graph permissions, license, or tenant configuration. Endpoint READMEs
link to the public API documentation for those deployment requirements. Live-tenant
integration checks are separate and opt-in; generated modules do not claim live
tenant coverage merely because their offline tests pass.

Each [GitHub Release](https://github.com/benhaspalace/GraphModules/releases)
contains:

- `graphmodules-v1.0-modules.tar.gz`
- `graphmodules-beta-modules.tar.gz`
- `graphmodules-curated-modules.tar.gz`
- `release-manifest.json`
- `SHA256SUMS`

## Public documentation

- [Microsoft Graph overview](https://learn.microsoft.com/en-us/graph/overview)
- [Microsoft Graph REST API v1.0 reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true)
- [Microsoft Graph versioning and beta support](https://learn.microsoft.com/en-us/graph/versioning-and-support)
- [Microsoft Graph permissions reference](https://learn.microsoft.com/en-us/graph/permissions-reference)
- [`microsoft/msgraph` Terraform provider](https://registry.terraform.io/providers/microsoft/msgraph/latest/docs)
- [Terraform module source syntax](https://developer.hashicorp.com/terraform/language/modules/configuration)

## Licensing and community

The repository code and curated modules are available under the
[MIT License](LICENSE). Generated schema descriptions and module interfaces are
derived from Microsoft Graph metadata, which Microsoft publishes under the MIT
License. Catalog categories and resource links are adapted from Microsoft Graph
documentation under Creative Commons Attribution 4.0. See [NOTICE](NOTICE) for
the upstream notices and license details.

Microsoft Graph and related names may be trademarks of Microsoft Corporation.
This independent project is not affiliated with or endorsed by Microsoft.

See [CONTRIBUTING.md](CONTRIBUTING.md) before proposing a change. Participation
is governed by the [Code of Conduct](CODE_OF_CONDUCT.md), and vulnerabilities
should be reported according to [SECURITY.md](SECURITY.md).
