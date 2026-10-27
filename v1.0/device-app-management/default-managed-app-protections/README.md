# /deviceAppManagement/defaultManagedAppProtections

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive inputs: `additional_properties`, `organizational_credentials_required`.
Sensitive outputs: `response`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

Create new navigation property to defaultManagedAppProtections for deviceAppManagement

[Catalog](../../README.md) Â· [Device and app management](../../README.md#device-and-app-management) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-defaultmanagedappprotection?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceAppManagement/defaultManagedAppProtections`, `GET/PATCH/DELETE /deviceAppManagement/defaultManagedAppProtections/{defaultManagedAppProtection-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//v1.0/device-app-management/default-managed-app-protections"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

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
| `allowed_data_storage_locations` | `allowedDataStorageLocations` | `list(string)` | no | no | in place |
| `allowed_inbound_data_transfer_sources` | `allowedInboundDataTransferSources` | `string` | no | no | in place |
| `allowed_outbound_clipboard_sharing_level` | `allowedOutboundClipboardSharingLevel` | `string` | no | no | in place |
| `allowed_outbound_data_transfer_destinations` | `allowedOutboundDataTransferDestinations` | `string` | no | no | in place |
| `app_data_encryption_type` | `appDataEncryptionType` | `string` | no | no | in place |
| `apps` | `apps` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedMobileApp")       mobileAppIdentifier = optional(any)       version = optional(string)     }))` | no | no | in place |
| `contact_sync_blocked` | `contactSyncBlocked` | `bool` | no | no | in place |
| `created_date_time` | `createdDateTime` | `string` | no | no | in place |
| `custom_settings` | `customSettings` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyValuePair")       name = optional(string)       value = optional(string)     }))` | no | no | in place |
| `data_backup_blocked` | `dataBackupBlocked` | `bool` | no | no | in place |
| `deployed_app_count` | `deployedAppCount` | `number` | no | no | in place |
| `deployment_summary` | `deploymentSummary` | `any` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `device_compliance_required` | `deviceComplianceRequired` | `bool` | no | no | in place |
| `disable_app_encryption_if_device_encryption_is_enabled` | `disableAppEncryptionIfDeviceEncryptionIsEnabled` | `bool` | no | no | in place |
| `disable_app_pin_if_device_pin_is_set` | `disableAppPinIfDevicePinIsSet` | `bool` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `encrypt_app_data` | `encryptAppData` | `bool` | no | no | in place |
| `face_id_blocked` | `faceIdBlocked` | `bool` | no | no | in place |
| `fingerprint_blocked` | `fingerprintBlocked` | `bool` | no | no | in place |
| `graph_version` | `version` | `string` | no | no | in place |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no | in place |
| `managed_browser` | `managedBrowser` | `string` | no | no | in place |
| `managed_browser_to_open_links_required` | `managedBrowserToOpenLinksRequired` | `bool` | no | no | in place |
| `maximum_pin_retries` | `maximumPinRetries` | `number` | no | no | in place |
| `minimum_pin_length` | `minimumPinLength` | `number` | no | no | in place |
| `minimum_required_app_version` | `minimumRequiredAppVersion` | `string` | no | no | in place |
| `minimum_required_os_version` | `minimumRequiredOsVersion` | `string` | no | no | in place |
| `minimum_required_patch_version` | `minimumRequiredPatchVersion` | `string` | no | no | in place |
| `minimum_required_sdk_version` | `minimumRequiredSdkVersion` | `string` | no | no | in place |
| `minimum_warning_app_version` | `minimumWarningAppVersion` | `string` | no | no | in place |
| `minimum_warning_os_version` | `minimumWarningOsVersion` | `string` | no | no | in place |
| `minimum_warning_patch_version` | `minimumWarningPatchVersion` | `string` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `organizational_credentials_required` | `organizationalCredentialsRequired` | `bool` | no | yes | in place |
| `period_before_pin_reset` | `periodBeforePinReset` | `string` | no | no | in place |
| `period_offline_before_access_check` | `periodOfflineBeforeAccessCheck` | `string` | no | no | in place |
| `period_offline_before_wipe_is_enforced` | `periodOfflineBeforeWipeIsEnforced` | `string` | no | no | in place |
| `period_online_before_access_check` | `periodOnlineBeforeAccessCheck` | `string` | no | no | in place |
| `pin_character_set` | `pinCharacterSet` | `string` | no | no | in place |
| `pin_required` | `pinRequired` | `bool` | no | no | in place |
| `print_blocked` | `printBlocked` | `bool` | no | no | in place |
| `save_as_blocked` | `saveAsBlocked` | `bool` | no | no | in place |
| `screen_capture_blocked` | `screenCaptureBlocked` | `bool` | no | no | in place |
| `simple_pin_blocked` | `simplePinBlocked` | `bool` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `id`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- apps[].mobileAppIdentifier: polymorphic schema; accepts an untyped value
- deploymentSummary: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
