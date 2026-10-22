# /directory/administrativeUnits/{administrativeUnit-id}/scopedRoleMembers

Add a scopedRoleMember

[Catalog](../../../README.md) · [Identity and access](../../../README.md#identity-and-access) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /directory/administrativeUnits/{administrativeUnit-id}/scopedRoleMembers`, `GET/PATCH/DELETE /directory/administrativeUnits/{administrativeUnit-id}/scopedRoleMembers/{scopedRoleMembership-id}`.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//v1.0/directory/administrative-units/scoped-role-members"
  version = "<version>"

  administrative_unit_id = "parent-object-id"
}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `administrative_unit_id` | URL parameter `administrativeUnit-id` | `string` | yes | no |
| `administrative_unit_id_2` | `administrativeUnitId` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `role_id` | `roleId` | `string` | no | no |
| `role_member_info` | `roleMemberInfo` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- roleMemberInfo: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

Feature rules reviewed on 2026-10-19 for the Microsoft Entra feature this endpoint belongs to (confidence: inferred). Input-dependent rules were not verified against this module's inputs.

A scoped role member assigns a Microsoft Entra role at the scope of the administrative unit, so the ADMIN-UNITS rule applies to each such administrator.

- **ADMIN-UNITS**: Creating administrative units is available with Microsoft Entra ID Free, and their members need only Microsoft Entra ID Free. Each administrator who is assigned a Microsoft Entra role at the scope of an administrative unit, including a restricted management administrative unit, needs Microsoft Entra ID P1. Any of: Microsoft Entra ID P1 (`AAD_PREMIUM`). Coverage: Each administrator assigned a Microsoft Entra role scoped to the administrative unit; the members of the unit need only Microsoft Entra ID Free. Assignment: direct; capacity: per_user. Sources: [Administrative units license requirements](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/administrative-units#license-requirements), [Restricted management administrative units license requirements](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/admin-units-restricted-management#license-requirements).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
