# /directory/administrativeUnits

Create administrativeUnit

[Catalog](../../README.md) · [Identity and access](../../README.md#identity-and-access) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/administrativeunit?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /directory/administrativeUnits`, `GET/PATCH/DELETE /directory/administrativeUnits/{administrativeUnit-id}`.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//v1.0/directory/administrative-units"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `extensions` | `extensions` | `any` | no | no |
| `is_member_management_restricted` | `isMemberManagementRestricted` | `bool` | no | no |
| `members` | `members` | `any` | no | no |
| `membership_rule` | `membershipRule` | `string` | no | no |
| `membership_rule_processing_state` | `membershipRuleProcessingState` | `string` | no | no |
| `membership_type` | `membershipType` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `scoped_role_members` | `scopedRoleMembers` | `list(object({       odata_type = optional(string, "#microsoft.graph.scopedRoleMembership")       administrativeUnitId = optional(string)       roleId = optional(string)       roleMemberInfo = optional(any)     }))` | no | no |
| `visibility` | `visibility` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- extensions[]: polymorphic schema; accepts an untyped value
- members[]: polymorphic schema; accepts an untyped value
- scopedRoleMembers[].roleMemberInfo: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

Baseline rules reviewed on 2026-10-19 for the equivalent verified module `verified/directory/administrative-units` (confidence: inferred). Input-dependent rules were not re-verified against this module's inputs.

Dynamic membership rules also need the ADMIN-UNITS-DYNAMIC rule, which the verified module applies to that input.

- **DIRECTORY-BASIC**: The reviewed create APIs for users, assigned security groups, applications and service principals specify no additional premium license. This covers the object operation only; features built on these objects can require licenses. No additional license specified. Coverage: No per-user entitlement for the object operation itself. Assignment: direct; capacity: per_tenant. Sources: [Create user](https://learn.microsoft.com/en-us/graph/api/user-post-users?view=graph-rest-1.0), [Create group](https://learn.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0), [Create application](https://learn.microsoft.com/en-us/graph/api/application-post-applications?view=graph-rest-1.0), [Create servicePrincipal](https://learn.microsoft.com/en-us/graph/api/serviceprincipal-post-serviceprincipals?view=graph-rest-1.0).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
