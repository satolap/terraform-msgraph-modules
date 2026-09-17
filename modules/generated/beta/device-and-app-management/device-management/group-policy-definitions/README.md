# /deviceManagement/groupPolicyDefinitions

Create new navigation property to groupPolicyDefinitions for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-grouppolicy-grouppolicydefinition?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/groupPolicyDefinitions`, `GET/PATCH/DELETE /deviceManagement/groupPolicyDefinitions/{groupPolicyDefinition-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/group-policy-definitions"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `category` | `category` | `any` | no | no |
| `category_path` | `categoryPath` | `string` | no | no |
| `class_type` | `classType` | `string` | no | no |
| `definition_file` | `definitionFile` | `any` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `explain_text` | `explainText` | `string` | no | no |
| `graph_version` | `version` | `string` | no | no |
| `group_policy_category_id` | `groupPolicyCategoryId` | `string` | no | no |
| `has_related_definitions` | `hasRelatedDefinitions` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `min_device_csp_version` | `minDeviceCspVersion` | `string` | no | no |
| `min_user_csp_version` | `minUserCspVersion` | `string` | no | no |
| `next_version_definition` | `nextVersionDefinition` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `policy_type` | `policyType` | `string` | no | no |
| `presentations` | `presentations` | `list(object({       odata_type = optional(string, "#microsoft.graph.groupPolicyPresentation")       definition = optional(any)       label = optional(string)       lastModifiedDateTime = optional(string)     }))` | no | no |
| `previous_version_definition` | `previousVersionDefinition` | `any` | no | no |
| `supported_on` | `supportedOn` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- category: polymorphic schema; accepts an untyped value
- definitionFile: polymorphic schema; accepts an untyped value
- nextVersionDefinition: polymorphic schema; accepts an untyped value
- presentations[].definition: polymorphic schema; accepts an untyped value
- previousVersionDefinition: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
