# /shares/{sharedDriveItem-id}/list/subscriptions

Create new navigation property to subscriptions for shares

[Catalog](../../../../../README.md) · [Change notifications](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/subscription?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /shares/{sharedDriveItem-id}/list/subscriptions`, `GET/PATCH/DELETE /shares/{sharedDriveItem-id}/list/subscriptions/{subscription-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./change-notifications/shares/by-shared-drive-item-id/list/subscriptions"
  shared_drive_item_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `shared_drive_item_id` | URL parameter `sharedDriveItem-id` | `string` | yes | no |
| `change_type` | `changeType` | `string` | no | no |
| `client_state` | `clientState` | `string` | no | no |
| `encryption_certificate` | `encryptionCertificate` | `string` | no | no |
| `encryption_certificate_id` | `encryptionCertificateId` | `string` | no | no |
| `expiration_date_time` | `expirationDateTime` | `string` | no | no |
| `include_resource_data` | `includeResourceData` | `bool` | no | no |
| `latest_supported_tls_version` | `latestSupportedTlsVersion` | `string` | no | no |
| `lifecycle_notification_url` | `lifecycleNotificationUrl` | `string` | no | no |
| `notification_content_type` | `notificationContentType` | `string` | no | no |
| `notification_query_options` | `notificationQueryOptions` | `string` | no | no |
| `notification_url` | `notificationUrl` | `string` | no | no |
| `notification_url_app_id` | `notificationUrlAppId` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `resource` | `resource` | `string` | no | no |
| `vapid_public_key` | `vapidPublicKey` | `string` | no | no |
| `web_push_encryption_p256dh_public_key` | `webPushEncryptionP256dhPublicKey` | `string` | no | no |
| `web_push_encryption_secret` | `webPushEncryptionSecret` | `string` | no | yes |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
