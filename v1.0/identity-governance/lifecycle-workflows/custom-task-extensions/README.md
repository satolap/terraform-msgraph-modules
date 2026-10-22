# /identityGovernance/lifecycleWorkflows/customTaskExtensions

Create customTaskExtensions

[Catalog](../../../README.md) · [Identity and access](../../../README.md#identity-and-access) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/identitygovernance-customtaskextension?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/lifecycleWorkflows/customTaskExtensions`, `GET/PATCH/DELETE /identityGovernance/lifecycleWorkflows/customTaskExtensions/{customTaskExtension-id}`.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//v1.0/identity-governance/lifecycle-workflows/custom-task-extensions"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `authentication_configuration` | `authenticationConfiguration` | `any` | no | no |
| `callback_configuration` | `callbackConfiguration` | `any` | no | no |
| `client_configuration` | `clientConfiguration` | `object({       odata_type = optional(string, "#microsoft.graph.customExtensionClientConfiguration")       maximumRetries = optional(number)       timeoutInMilliseconds = optional(number)     })` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `endpoint_configuration` | `endpointConfiguration` | `any` | no | no |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `reply_mode` | `replyMode` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- authenticationConfiguration: polymorphic schema; accepts an untyped value
- callbackConfiguration: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- endpointConfiguration: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

Feature rules reviewed on 2026-10-19 for the Microsoft Entra feature this endpoint belongs to (confidence: inferred). Input-dependent rules were not verified against this module's inputs.

- **LIFECYCLE-WORKFLOWS**: Lifecycle workflows, including their custom task extensions, require Microsoft Entra ID Governance or Microsoft Entra Suite for the organization's member users. Microsoft Entra ID P2 alone is not sufficient. Agent sponsorship tasks need Microsoft Agent 365, and some capabilities involve guest billing. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). Coverage: Every member user a workflow processes, and the Lifecycle Workflows administrator. Assignment: direct; capacity: per_user. Sources: [Lifecycle workflows license requirements](https://learn.microsoft.com/en-us/entra/id-governance/what-are-lifecycle-workflows#license-requirements), [Microsoft Entra licensing: lifecycle workflows](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#lifecycle-workflows), [Microsoft Entra ID Governance licensing fundamentals: licensing FAQs](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#licensing-faqs).

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
