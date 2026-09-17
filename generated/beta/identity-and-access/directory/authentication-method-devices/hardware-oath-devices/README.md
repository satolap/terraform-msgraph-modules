# /directory/authenticationMethodDevices/hardwareOathDevices

Create hardwareOathTokenAuthenticationMethodDevice

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/hardwareoathtokenauthenticationmethoddevice?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /directory/authenticationMethodDevices/hardwareOathDevices`, `GET/PATCH/DELETE /directory/authenticationMethodDevices/hardwareOathDevices/{hardwareOathTokenAuthenticationMethodDevice-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/directory/authentication-method-devices/hardware-oath-devices"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `assign_to` | `assignTo` | `any` | no | no |
| `assigned_to` | `assignedTo` | `any` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `hardware_oath_devices` | `hardwareOathDevices` | `list(object({       odata_type = optional(string, "#microsoft.graph.hardwareOathTokenAuthenticationMethodDevice")       assignTo = optional(any)       assignedTo = optional(any)       displayName = optional(string)       hardwareOathDevices = optional(any)       hashFunction = optional(any)       manufacturer = optional(string)       model = optional(string)       secretKey = optional(string)       serialNumber = optional(string)       status = optional(any)       timeIntervalInSeconds = optional(number)     }))` | no | yes |
| `hash_function` | `hashFunction` | `any` | no | no |
| `manufacturer` | `manufacturer` | `string` | no | no |
| `model` | `model` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `secret_key` | `secretKey` | `string` | no | yes |
| `serial_number` | `serialNumber` | `string` | no | no |
| `status` | `status` | `any` | no | no |
| `time_interval_in_seconds` | `timeIntervalInSeconds` | `number` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- assignTo: polymorphic schema; accepts an untyped value
- assignedTo: polymorphic schema; accepts an untyped value
- hardwareOathDevices[].assignTo: polymorphic schema; accepts an untyped value
- hardwareOathDevices[].assignedTo: polymorphic schema; accepts an untyped value
- hardwareOathDevices[].hardwareOathDevices[]: recursive schema; accepts an untyped value
- hardwareOathDevices[].hashFunction: polymorphic schema; accepts an untyped value
- hardwareOathDevices[].status: polymorphic schema; accepts an untyped value
- hashFunction: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
