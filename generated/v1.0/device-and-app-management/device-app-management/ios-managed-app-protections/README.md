# /deviceAppManagement/iosManagedAppProtections

Create new navigation property to iosManagedAppProtections for deviceAppManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-iosmanagedappprotection?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceAppManagement/iosManagedAppProtections`, `GET/PATCH/DELETE /deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-app-management/ios-managed-app-protections"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `allowed_data_storage_locations` | `allowedDataStorageLocations` | `list(string)` | no | no |
| `allowed_inbound_data_transfer_sources` | `allowedInboundDataTransferSources` | `string` | no | no |
| `allowed_outbound_clipboard_sharing_level` | `allowedOutboundClipboardSharingLevel` | `string` | no | no |
| `allowed_outbound_data_transfer_destinations` | `allowedOutboundDataTransferDestinations` | `string` | no | no |
| `app_data_encryption_type` | `appDataEncryptionType` | `string` | no | no |
| `apps` | `apps` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedMobileApp")       mobileAppIdentifier = optional(any)       version = optional(string)     }))` | no | no |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.targetedManagedAppPolicyAssignment")       target = optional(any)     }))` | no | no |
| `contact_sync_blocked` | `contactSyncBlocked` | `bool` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `custom_browser_protocol` | `customBrowserProtocol` | `string` | no | no |
| `data_backup_blocked` | `dataBackupBlocked` | `bool` | no | no |
| `deployed_app_count` | `deployedAppCount` | `number` | no | no |
| `deployment_summary` | `deploymentSummary` | `any` | no | no |
| `description` | `description` | `string` | no | no |
| `device_compliance_required` | `deviceComplianceRequired` | `bool` | no | no |
| `disable_app_pin_if_device_pin_is_set` | `disableAppPinIfDevicePinIsSet` | `bool` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `face_id_blocked` | `faceIdBlocked` | `bool` | no | no |
| `fingerprint_blocked` | `fingerprintBlocked` | `bool` | no | no |
| `graph_version` | `version` | `string` | no | no |
| `is_assigned` | `isAssigned` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `managed_browser` | `managedBrowser` | `string` | no | no |
| `managed_browser_to_open_links_required` | `managedBrowserToOpenLinksRequired` | `bool` | no | no |
| `maximum_pin_retries` | `maximumPinRetries` | `number` | no | no |
| `minimum_pin_length` | `minimumPinLength` | `number` | no | no |
| `minimum_required_app_version` | `minimumRequiredAppVersion` | `string` | no | no |
| `minimum_required_os_version` | `minimumRequiredOsVersion` | `string` | no | no |
| `minimum_required_sdk_version` | `minimumRequiredSdkVersion` | `string` | no | no |
| `minimum_warning_app_version` | `minimumWarningAppVersion` | `string` | no | no |
| `minimum_warning_os_version` | `minimumWarningOsVersion` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `organizational_credentials_required` | `organizationalCredentialsRequired` | `bool` | no | yes |
| `period_before_pin_reset` | `periodBeforePinReset` | `string` | no | no |
| `period_offline_before_access_check` | `periodOfflineBeforeAccessCheck` | `string` | no | no |
| `period_offline_before_wipe_is_enforced` | `periodOfflineBeforeWipeIsEnforced` | `string` | no | no |
| `period_online_before_access_check` | `periodOnlineBeforeAccessCheck` | `string` | no | no |
| `pin_character_set` | `pinCharacterSet` | `string` | no | no |
| `pin_required` | `pinRequired` | `bool` | no | no |
| `print_blocked` | `printBlocked` | `bool` | no | no |
| `save_as_blocked` | `saveAsBlocked` | `bool` | no | no |
| `simple_pin_blocked` | `simplePinBlocked` | `bool` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- apps[].mobileAppIdentifier: polymorphic schema; accepts an untyped value
- assignments[].target: polymorphic schema; accepts an untyped value
- deploymentSummary: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
