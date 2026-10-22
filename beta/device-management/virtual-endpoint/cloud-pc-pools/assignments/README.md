# /deviceManagement/virtualEndpoint/cloudPcPools/{cloudPcPool-id}/assignments

Create cloudPcPoolAssignment

[Catalog](../../../../README.md) · [Device and app management](../../../../README.md#device-and-app-management) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/cloudpcpoolassignment?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/virtualEndpoint/cloudPcPools/{cloudPcPool-id}/assignments`, `GET/PATCH/DELETE /deviceManagement/virtualEndpoint/cloudPcPools/{cloudPcPool-id}/assignments/{cloudPcPoolAssignment-id}`.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/device-management/virtual-endpoint/cloud-pc-pools/assignments"
  version = "<version>"

  cloud_pc_pool_id = "parent-object-id"
  odata_type = "#microsoft.graph.cloudPcAgentPoolUserAssignment"
}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `cloud_pc_pool_id` | URL parameter `cloudPcPool-id` | `string` | yes | no |
| `odata_type` | `@odata.type` | `string` | yes | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults, except for abstract types listed in the generation notes: set their `odata_type` to a concrete type.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- @odata.type: microsoft.graph.cloudPcPoolAssignment is abstract; odata_type has no default and must name a concrete type
- Microsoft Graph beta contracts can change without notice.

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
