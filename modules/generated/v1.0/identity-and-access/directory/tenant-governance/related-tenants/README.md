# /directory/tenantGovernance/relatedTenants

Create new navigation property to relatedTenants for directory

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /directory/tenantGovernance/relatedTenants`, `GET/PATCH/DELETE /directory/tenantGovernance/relatedTenants/{relatedTenant-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/directory/tenant-governance/related-tenants"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `app_b2_b_sign_in_activity_metrics` | `appB2BSignInActivityMetrics` | `any` | no | no |
| `b2_b_registration_metrics` | `b2BRegistrationMetrics` | `any` | no | no |
| `b2_b_sign_in_activity_metrics` | `b2BSignInActivityMetrics` | `any` | no | no |
| `billing_metrics` | `billingMetrics` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `multi_tenant_application_metrics` | `multiTenantApplicationMetrics` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- appB2BSignInActivityMetrics: polymorphic schema; accepts an untyped value
- b2BRegistrationMetrics: polymorphic schema; accepts an untyped value
- b2BSignInActivityMetrics: polymorphic schema; accepts an untyped value
- billingMetrics: polymorphic schema; accepts an untyped value
- multiTenantApplicationMetrics: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
