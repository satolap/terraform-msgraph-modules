# /subscriptions

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive inputs: `additional_properties`, `web_push_encryption_secret`.
Sensitive outputs: `response`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

Create subscription

[Catalog](../README.md) Â· [Change notifications](../README.md#change-notifications) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/subscription?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /subscriptions`, `GET/PATCH/DELETE /subscriptions/{subscription-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/subscriptions"
  version = "<version>"

  change_type = "example"
  expiration_date_time = "2026-01-01T00:00:00Z"
  notification_url = "example"
  resource = "example"
}
```

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

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

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

No select-only inputs are identified by this metadata and contract; classification is incomplete.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `change_type` | `changeType` | `string` | yes | no | replaces object |
| `expiration_date_time` | `expirationDateTime` | `string` | yes | no | in place |
| `notification_url` | `notificationUrl` | `string` | yes | no | in place |
| `resource` | `resource` | `string` | yes | no | replaces object |
| `client_state` | `clientState` | `string` | no | no | replaces object |
| `encryption_certificate` | `encryptionCertificate` | `string` | no | no | replaces object |
| `encryption_certificate_id` | `encryptionCertificateId` | `string` | no | no | replaces object |
| `include_resource_data` | `includeResourceData` | `bool` | no | no | replaces object |
| `latest_supported_tls_version` | `latestSupportedTlsVersion` | `string` | no | no | replaces object |
| `lifecycle_notification_url` | `lifecycleNotificationUrl` | `string` | no | no | replaces object |
| `notification_content_type` | `notificationContentType` | `string` | no | no | replaces object |
| `notification_query_options` | `notificationQueryOptions` | `string` | no | no | replaces object |
| `notification_url_app_id` | `notificationUrlAppId` | `string` | no | no | replaces object |
| `odata_type` | `@odata.type` | `string` | no | no | replaces object |
| `vapid_public_key` | `vapidPublicKey` | `string` | no | no | replaces object |
| `web_push_encryption_p256dh_public_key` | `webPushEncryptionP256dhPublicKey` | `string` | no | no | replaces object |
| `web_push_encryption_secret` | `webPushEncryptionSecret` | `string` | no | yes | replaces object |
| `additional_properties` | Additional writable API properties | `any` | no | yes | replaces object, except keys `expirationDateTime`, `notificationUrl` |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `applicationId`, `creatorId`, `id`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /subscriptions` | DelegatedWork | Unknown / not annotated | — |
| `POST /subscriptions` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /subscriptions` | Application | Unknown / not annotated | — |
| `GET /subscriptions/{subscription-id}` | DelegatedWork | Unknown / not annotated | — |
| `GET /subscriptions/{subscription-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /subscriptions/{subscription-id}` | Application | Unknown / not annotated | — |
| `PATCH /subscriptions/{subscription-id}` | DelegatedWork | Unknown / not annotated | — |
| `PATCH /subscriptions/{subscription-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PATCH /subscriptions/{subscription-id}` | Application | Unknown / not annotated | — |
| `DELETE /subscriptions/{subscription-id}` | DelegatedWork | Unknown / not annotated | — |
| `DELETE /subscriptions/{subscription-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /subscriptions/{subscription-id}` | Application | Unknown / not annotated | — |

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
