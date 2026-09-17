# /auditLogs/signIns

Create new navigation property to signIns for auditLogs

[Catalog](../../../README.md) · [Reports](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/signin?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /auditLogs/signIns`, `GET/PATCH/DELETE /auditLogs/signIns/{signIn-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./reports/audit-logs/sign-ins"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `app_display_name` | `appDisplayName` | `string` | no | no |
| `app_id` | `appId` | `string` | no | no |
| `applied_conditional_access_policies` | `appliedConditionalAccessPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.appliedConditionalAccessPolicy")       displayName = optional(string)       enforcedGrantControls = optional(list(string))       enforcedSessionControls = optional(list(string))       id = optional(string)       result = optional(any)     }))` | no | no |
| `authentication_app_device_details` | `authenticationAppDeviceDetails` | `any` | no | no |
| `client_app_used` | `clientAppUsed` | `string` | no | no |
| `conditional_access_status` | `conditionalAccessStatus` | `any` | no | no |
| `correlation_id` | `correlationId` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `device_detail` | `deviceDetail` | `any` | no | no |
| `home_tenant_id` | `homeTenantId` | `string` | no | no |
| `ip_address` | `ipAddress` | `string` | no | no |
| `is_interactive` | `isInteractive` | `bool` | no | no |
| `location` | `location` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `resource_display_name` | `resourceDisplayName` | `string` | no | no |
| `resource_id` | `resourceId` | `string` | no | no |
| `resource_tenant_id` | `resourceTenantId` | `string` | no | no |
| `risk_detail` | `riskDetail` | `any` | no | no |
| `risk_event_types` | `riskEventTypes` | `any` | no | no |
| `risk_event_types_v2` | `riskEventTypes_v2` | `list(string)` | no | no |
| `risk_level_aggregated` | `riskLevelAggregated` | `any` | no | no |
| `risk_level_during_sign_in` | `riskLevelDuringSignIn` | `any` | no | no |
| `risk_state` | `riskState` | `any` | no | no |
| `service_principal_id` | `servicePrincipalId` | `string` | no | no |
| `service_principal_name` | `servicePrincipalName` | `string` | no | no |
| `status` | `status` | `any` | no | no |
| `user_agent` | `userAgent` | `string` | no | no |
| `user_display_name` | `userDisplayName` | `string` | no | no |
| `user_id` | `userId` | `string` | no | no |
| `user_principal_name` | `userPrincipalName` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- appliedConditionalAccessPolicies[].result: polymorphic schema; accepts an untyped value
- authenticationAppDeviceDetails: polymorphic schema; accepts an untyped value
- conditionalAccessStatus: polymorphic schema; accepts an untyped value
- deviceDetail: polymorphic schema; accepts an untyped value
- location: polymorphic schema; accepts an untyped value
- riskDetail: polymorphic schema; accepts an untyped value
- riskEventTypes[]: polymorphic schema; accepts an untyped value
- riskLevelAggregated: polymorphic schema; accepts an untyped value
- riskLevelDuringSignIn: polymorphic schema; accepts an untyped value
- riskState: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
