# /templates/deviceTemplates

Create new navigation property to deviceTemplates for templates

[Catalog](../../../README.md) · [Identity and access](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/devicetemplate?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /templates/deviceTemplates`, `GET/PATCH/DELETE /templates/deviceTemplates/{deviceTemplate-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/templates/device-templates"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `device_authority` | `deviceAuthority` | `string` | no | no |
| `device_instances` | `deviceInstances` | `list(object({       odata_type = optional(string, "#microsoft.graph.device")       accountEnabled = optional(bool)       alternativeNames = optional(list(string))       alternativeSecurityIds = optional(list(object({       odata_type = optional(string, "#microsoft.graph.alternativeSecurityId")       identityProvider = optional(string)       key = optional(string)       type = optional(number)     })))       commands = optional(list(object({       odata_type = optional(string, "#microsoft.graph.command")       appServiceName = optional(string)       error = optional(string)       packageFamilyName = optional(string)       payload = optional(any)       permissionTicket = optional(string)       postBackUri = optional(string)       responsepayload = optional(any)       status = optional(string)       type = optional(string)     })))       deletedDateTime = optional(string)       deviceCategory = optional(string)       deviceId = optional(string)       deviceMetadata = optional(string)       deviceOwnership = optional(string)       deviceVersion = optional(number)       displayName = optional(string)       domainName = optional(string)       enrollmentProfileName = optional(string)       enrollmentType = optional(string)       extensionAttributes = optional(any)       hostnames = optional(list(string))       isManaged = optional(bool)       isRooted = optional(bool)       kind = optional(string)       managementType = optional(string)       name = optional(string)       operatingSystem = optional(string)       operatingSystemVersion = optional(string)       physicalIds = optional(list(string))       platform = optional(string)       profileType = optional(string)       status = optional(string)       systemLabels = optional(list(string))       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       usageRights = optional(list(object({       odata_type = optional(string, "#microsoft.graph.usageRight")       catalogId = optional(string)       serviceIdentifier = optional(string)       state = optional(string)     })))     }))` | no | no |
| `manufacturer` | `manufacturer` | `string` | no | no |
| `model` | `model` | `string` | no | no |
| `mutual_tls_oauth_configuration_id` | `mutualTlsOauthConfigurationId` | `string` | no | no |
| `mutual_tls_oauth_configuration_tenant_id` | `mutualTlsOauthConfigurationTenantId` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `operating_system` | `operatingSystem` | `string` | no | no |
| `owners` | `owners` | `list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- deviceInstances[].commands[].payload: polymorphic schema; accepts an untyped value
- deviceInstances[].commands[].responsepayload: polymorphic schema; accepts an untyped value
- deviceInstances[].extensionAttributes: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
