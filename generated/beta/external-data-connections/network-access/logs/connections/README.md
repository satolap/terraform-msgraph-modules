# /networkAccess/logs/connections

Create new navigation property to connections for networkAccess

[Catalog](../../../../README.md) · [External data connections](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/connectors-api-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /networkAccess/logs/connections`, `GET/PATCH/DELETE /networkAccess/logs/connections/{connection-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./external-data-connections/network-access/logs/connections"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `agent_version` | `agentVersion` | `string` | no | no |
| `application_snapshot` | `applicationSnapshot` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `cross_tenant_access_type` | `crossTenantAccessType` | `any` | no | no |
| `destination_fqdn` | `destinationFqdn` | `string` | no | no |
| `destination_ip` | `destinationIp` | `string` | no | no |
| `destination_port` | `destinationPort` | `number` | no | no |
| `device_category` | `deviceCategory` | `any` | no | no |
| `device_id` | `deviceId` | `string` | no | no |
| `device_join_type` | `deviceJoinType` | `any` | no | no |
| `device_operating_system` | `deviceOperatingSystem` | `string` | no | no |
| `device_operating_system_version` | `deviceOperatingSystemVersion` | `string` | no | no |
| `end_date_time` | `endDateTime` | `string` | no | no |
| `home_tenant_id` | `homeTenantId` | `string` | no | no |
| `initiating_process_name` | `initiatingProcessName` | `string` | no | no |
| `last_update_date_time` | `lastUpdateDateTime` | `string` | no | no |
| `network_protocol` | `networkProtocol` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `pop_processing_region` | `popProcessingRegion` | `string` | no | no |
| `private_access_details` | `privateAccessDetails` | `any` | no | no |
| `received_bytes` | `receivedBytes` | `number` | no | no |
| `sent_bytes` | `sentBytes` | `number` | no | no |
| `source_ip` | `sourceIp` | `string` | no | no |
| `source_port` | `sourcePort` | `number` | no | no |
| `status` | `status` | `any` | no | no |
| `tenant_id` | `tenantId` | `string` | no | no |
| `traffic_type` | `trafficType` | `string` | no | no |
| `transaction_block_count` | `transactionBlockCount` | `number` | no | no |
| `transaction_count` | `transactionCount` | `number` | no | no |
| `transport_protocol` | `transportProtocol` | `any` | no | no |
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

- Microsoft Graph beta contracts can change without notice.
- applicationSnapshot: polymorphic schema; accepts an untyped value
- crossTenantAccessType: polymorphic schema; accepts an untyped value
- deviceCategory: polymorphic schema; accepts an untyped value
- deviceJoinType: polymorphic schema; accepts an untyped value
- networkProtocol: polymorphic schema; accepts an untyped value
- privateAccessDetails: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value
- transportProtocol: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
