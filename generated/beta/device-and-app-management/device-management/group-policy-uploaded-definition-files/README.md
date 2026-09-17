# /deviceManagement/groupPolicyUploadedDefinitionFiles

Create new navigation property to groupPolicyUploadedDefinitionFiles for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-grouppolicy-grouppolicyuploadeddefinitionfile?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/groupPolicyUploadedDefinitionFiles`, `GET/PATCH/DELETE /deviceManagement/groupPolicyUploadedDefinitionFiles/{groupPolicyUploadedDefinitionFile-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/group-policy-uploaded-definition-files"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `content` | `content` | `string` | no | no |
| `default_language_code` | `defaultLanguageCode` | `string` | no | no |
| `definitions` | `definitions` | `list(object({       odata_type = optional(string, "#microsoft.graph.groupPolicyDefinition")       category = optional(any)       categoryPath = optional(string)       classType = optional(string)       definitionFile = optional(any)       displayName = optional(string)       explainText = optional(string)       groupPolicyCategoryId = optional(string)       hasRelatedDefinitions = optional(bool)       lastModifiedDateTime = optional(string)       minDeviceCspVersion = optional(string)       minUserCspVersion = optional(string)       nextVersionDefinition = optional(any)       policyType = optional(string)       presentations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.groupPolicyPresentation")       definition = optional(any)       label = optional(string)       lastModifiedDateTime = optional(string)     })))       previousVersionDefinition = optional(any)       supportedOn = optional(string)       version = optional(string)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `file_name` | `fileName` | `string` | no | no |
| `group_policy_operations` | `groupPolicyOperations` | `list(object({       odata_type = optional(string, "#microsoft.graph.groupPolicyOperation")       lastModifiedDateTime = optional(string)       operationStatus = optional(string)       operationType = optional(string)       statusDetails = optional(string)     }))` | no | no |
| `group_policy_uploaded_language_files` | `groupPolicyUploadedLanguageFiles` | `list(object({       odata_type = optional(string, "#microsoft.graph.groupPolicyUploadedLanguageFile")       content = optional(string)       fileName = optional(string)       id = optional(string)       languageCode = optional(string)       lastModifiedDateTime = optional(string)     }))` | no | no |
| `language_codes` | `languageCodes` | `list(string)` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `policy_type` | `policyType` | `string` | no | no |
| `revision` | `revision` | `string` | no | no |
| `status` | `status` | `string` | no | no |
| `target_namespace` | `targetNamespace` | `string` | no | no |
| `target_prefix` | `targetPrefix` | `string` | no | no |
| `upload_date_time` | `uploadDateTime` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- definitions[].category: polymorphic schema; accepts an untyped value
- definitions[].definitionFile: polymorphic schema; accepts an untyped value
- definitions[].nextVersionDefinition: polymorphic schema; accepts an untyped value
- definitions[].presentations[].definition: polymorphic schema; accepts an untyped value
- definitions[].previousVersionDefinition: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
