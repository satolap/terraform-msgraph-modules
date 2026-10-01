# /subscriptions

Create subscription

[Catalog](../../README.md) · [Change notifications](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/subscription?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /subscriptions`, `GET/PATCH/DELETE /subscriptions/{subscription-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/change-notifications/subscriptions?ref=<release-tag>"
  change_type = "example"
  expiration_date_time = "2026-01-01T00:00:00Z"
  notification_url = "example"
  resource = "example"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Replacement on change

Microsoft Graph updates only `expiration_date_time` and `notification_url` in place; the generation notes cite the source. A change to any other input, set as a typed input or as the same key in `additional_properties`, plans a destroy and a create of `msgraph_resource.this` through `terraform_data.immutable` and `replace_triggered_by`, so `terraform apply -replace` is not needed. Terraform deletes the old object before it creates the new one (`create_before_destroy` is not set). The replacement has a new `id`, and anything that stored the old `id` must read the new one. `terraform_data.immutable` holds the values below and makes no API call.

| Input | Graph property |
| --- | --- |
| `odata_type` | `@odata.type` |
| `change_type` | `changeType` |
| `client_state` | `clientState` |
| `encryption_certificate` | `encryptionCertificate` |
| `encryption_certificate_id` | `encryptionCertificateId` |
| `include_resource_data` | `includeResourceData` |
| `latest_supported_tls_version` | `latestSupportedTlsVersion` |
| `lifecycle_notification_url` | `lifecycleNotificationUrl` |
| `notification_content_type` | `notificationContentType` |
| `notification_query_options` | `notificationQueryOptions` |
| `notification_url_app_id` | `notificationUrlAppId` |
| `resource` | `resource` |
| `vapid_public_key` | `vapidPublicKey` |
| `web_push_encryption_p256dh_public_key` | `webPushEncryptionP256dhPublicKey` |
| `web_push_encryption_secret` | `webPushEncryptionSecret` |

Any other key of `additional_properties` replaces the object too when its value changes, for example a writable property that the pinned schema lacks: `terraform_data.immutable` holds every non-null key that is not a typed input. The keys that update in place (`expirationDateTime`, `notificationUrl`) never replace the object. A value of a replacing key that is unknown at plan time plans a replacement, whether it is an input in the table or a key of `additional_properties`; an unknown value of a key that updates in place still plans an in-place update.

Terraform plans a replacement only when `terraform_data.immutable` is updated or replaced, not when it is created. After an upgrade from a release that lacked it, or after an import, apply once with unchanged inputs; a change to one of these inputs made in the apply that creates it still updates the object in place. The replacement behavior is covered by mocked tests only, not by a live tenant.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `change_type` | `changeType` | `string` | yes | no |
| `expiration_date_time` | `expirationDateTime` | `string` | yes | no |
| `notification_url` | `notificationUrl` | `string` | yes | no |
| `resource` | `resource` | `string` | yes | no |
| `client_state` | `clientState` | `string` | no | no |
| `encryption_certificate` | `encryptionCertificate` | `string` | no | no |
| `encryption_certificate_id` | `encryptionCertificateId` | `string` | no | no |
| `include_resource_data` | `includeResourceData` | `bool` | no | no |
| `latest_supported_tls_version` | `latestSupportedTlsVersion` | `string` | no | no |
| `lifecycle_notification_url` | `lifecycleNotificationUrl` | `string` | no | no |
| `notification_content_type` | `notificationContentType` | `string` | no | no |
| `notification_query_options` | `notificationQueryOptions` | `string` | no | no |
| `notification_url_app_id` | `notificationUrlAppId` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
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

- A replacement deletes the old subscription before it creates the new one, which uses the current expiration_date_time. Between the two no subscription of this module exists, so Microsoft Graph delivers no change notifications for it, and Microsoft documents that changes made before an app creates a subscription again are lost: fetch them separately, for example with a delta query (https://learn.microsoft.com/en-us/graph/change-notifications-lifecycle-events).
- Microsoft Graph beta contracts can change without notice.
- Reviewed create-required correction: changeType, expirationDateTime, notificationUrl, resource.
- Reviewed update correction: Microsoft Graph updates only expirationDateTime and notificationUrl in place (https://learn.microsoft.com/en-us/graph/api/subscription-update); a change to any other input replaces the object.
- Subscriptions expire and must be renewed before expirationDateTime; the module manages the object, not its renewal or notification delivery.

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. Its apply runs also check which input changes update the object in place and which replace it. It does not verify permissions or server behavior.
