# /deviceAppManagement/iosManagedAppProtections

Create new navigation property to iosManagedAppProtections for deviceAppManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

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
| `allow_widget_content_sync` | `allowWidgetContentSync` | `bool` | no | no |
| `allowed_data_ingestion_locations` | `allowedDataIngestionLocations` | `list(string)` | no | no |
| `allowed_data_storage_locations` | `allowedDataStorageLocations` | `list(string)` | no | no |
| `allowed_inbound_data_transfer_sources` | `allowedInboundDataTransferSources` | `string` | no | no |
| `allowed_ios_device_models` | `allowedIosDeviceModels` | `string` | no | no |
| `allowed_outbound_clipboard_sharing_exception_length` | `allowedOutboundClipboardSharingExceptionLength` | `number` | no | no |
| `allowed_outbound_clipboard_sharing_level` | `allowedOutboundClipboardSharingLevel` | `string` | no | no |
| `allowed_outbound_data_transfer_destinations` | `allowedOutboundDataTransferDestinations` | `string` | no | no |
| `app_action_if_account_is_clocked_out` | `appActionIfAccountIsClockedOut` | `any` | no | no |
| `app_action_if_device_compliance_required` | `appActionIfDeviceComplianceRequired` | `string` | no | no |
| `app_action_if_ios_device_model_not_allowed` | `appActionIfIosDeviceModelNotAllowed` | `string` | no | no |
| `app_action_if_maximum_pin_retries_exceeded` | `appActionIfMaximumPinRetriesExceeded` | `string` | no | no |
| `app_action_if_unable_to_authenticate_user` | `appActionIfUnableToAuthenticateUser` | `any` | no | no |
| `app_data_encryption_type` | `appDataEncryptionType` | `string` | no | no |
| `app_group_type` | `appGroupType` | `string` | no | no |
| `apps` | `apps` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedMobileApp")       mobileAppIdentifier = optional(any)       version = optional(string)     }))` | no | no |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.targetedManagedAppPolicyAssignment")       source = optional(string)       sourceId = optional(string)       target = optional(any)     }))` | no | no |
| `block_data_ingestion_into_organization_documents` | `blockDataIngestionIntoOrganizationDocuments` | `bool` | no | no |
| `contact_sync_blocked` | `contactSyncBlocked` | `bool` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `custom_browser_protocol` | `customBrowserProtocol` | `string` | no | no |
| `custom_dialer_app_protocol` | `customDialerAppProtocol` | `string` | no | no |
| `data_backup_blocked` | `dataBackupBlocked` | `bool` | no | no |
| `deployed_app_count` | `deployedAppCount` | `number` | no | no |
| `deployment_summary` | `deploymentSummary` | `any` | no | no |
| `description` | `description` | `string` | no | no |
| `device_compliance_required` | `deviceComplianceRequired` | `bool` | no | no |
| `dialer_restriction_level` | `dialerRestrictionLevel` | `string` | no | no |
| `disable_app_pin_if_device_pin_is_set` | `disableAppPinIfDevicePinIsSet` | `bool` | no | no |
| `disable_protection_of_managed_outbound_open_in_data` | `disableProtectionOfManagedOutboundOpenInData` | `bool` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `exempted_app_protocols` | `exemptedAppProtocols` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyValuePair")       name = optional(string)       value = optional(string)     }))` | no | no |
| `exempted_universal_links` | `exemptedUniversalLinks` | `list(string)` | no | no |
| `face_id_blocked` | `faceIdBlocked` | `bool` | no | no |
| `filter_open_in_to_only_managed_apps` | `filterOpenInToOnlyManagedApps` | `bool` | no | no |
| `fingerprint_blocked` | `fingerprintBlocked` | `bool` | no | no |
| `genmoji_configuration_state` | `genmojiConfigurationState` | `any` | no | no |
| `grace_period_to_block_apps_during_off_clock_hours` | `gracePeriodToBlockAppsDuringOffClockHours` | `string` | no | no |
| `graph_version` | `version` | `string` | no | no |
| `is_assigned` | `isAssigned` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `managed_browser` | `managedBrowser` | `string` | no | no |
| `managed_browser_to_open_links_required` | `managedBrowserToOpenLinksRequired` | `bool` | no | no |
| `managed_universal_links` | `managedUniversalLinks` | `list(string)` | no | no |
| `maximum_allowed_device_threat_level` | `maximumAllowedDeviceThreatLevel` | `string` | no | no |
| `maximum_pin_retries` | `maximumPinRetries` | `number` | no | no |
| `maximum_required_os_version` | `maximumRequiredOsVersion` | `string` | no | no |
| `maximum_warning_os_version` | `maximumWarningOsVersion` | `string` | no | no |
| `maximum_wipe_os_version` | `maximumWipeOsVersion` | `string` | no | no |
| `messaging_redirect_app_url_scheme` | `messagingRedirectAppUrlScheme` | `string` | no | no |
| `minimum_pin_length` | `minimumPinLength` | `number` | no | no |
| `minimum_required_app_version` | `minimumRequiredAppVersion` | `string` | no | no |
| `minimum_required_os_version` | `minimumRequiredOsVersion` | `string` | no | no |
| `minimum_required_sdk_version` | `minimumRequiredSdkVersion` | `string` | no | no |
| `minimum_warning_app_version` | `minimumWarningAppVersion` | `string` | no | no |
| `minimum_warning_os_version` | `minimumWarningOsVersion` | `string` | no | no |
| `minimum_warning_sdk_version` | `minimumWarningSdkVersion` | `string` | no | no |
| `minimum_wipe_app_version` | `minimumWipeAppVersion` | `string` | no | no |
| `minimum_wipe_os_version` | `minimumWipeOsVersion` | `string` | no | no |
| `minimum_wipe_sdk_version` | `minimumWipeSdkVersion` | `string` | no | no |
| `mobile_threat_defense_partner_priority` | `mobileThreatDefensePartnerPriority` | `any` | no | no |
| `mobile_threat_defense_remediation_action` | `mobileThreatDefenseRemediationAction` | `string` | no | no |
| `notification_restriction` | `notificationRestriction` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `organizational_credentials_required` | `organizationalCredentialsRequired` | `bool` | no | yes |
| `period_before_pin_reset` | `periodBeforePinReset` | `string` | no | no |
| `period_offline_before_access_check` | `periodOfflineBeforeAccessCheck` | `string` | no | no |
| `period_offline_before_wipe_is_enforced` | `periodOfflineBeforeWipeIsEnforced` | `string` | no | no |
| `period_online_before_access_check` | `periodOnlineBeforeAccessCheck` | `string` | no | no |
| `pin_character_set` | `pinCharacterSet` | `string` | no | no |
| `pin_required` | `pinRequired` | `bool` | no | no |
| `pin_required_instead_of_biometric_timeout` | `pinRequiredInsteadOfBiometricTimeout` | `string` | no | no |
| `previous_pin_block_count` | `previousPinBlockCount` | `number` | no | no |
| `print_blocked` | `printBlocked` | `bool` | no | no |
| `protect_inbound_data_from_unknown_sources` | `protectInboundDataFromUnknownSources` | `bool` | no | no |
| `protected_messaging_redirect_app_type` | `protectedMessagingRedirectAppType` | `string` | no | no |
| `purview_content_evaluation_required` | `purviewContentEvaluationRequired` | `string` | no | no |
| `role_scope_tag_ids` | `roleScopeTagIds` | `list(string)` | no | no |
| `save_as_blocked` | `saveAsBlocked` | `bool` | no | no |
| `screen_capture_configuration_state` | `screenCaptureConfigurationState` | `any` | no | no |
| `simple_pin_blocked` | `simplePinBlocked` | `bool` | no | no |
| `targeted_app_management_levels` | `targetedAppManagementLevels` | `string` | no | no |
| `third_party_keyboards_blocked` | `thirdPartyKeyboardsBlocked` | `bool` | no | no |
| `writing_tools_configuration_state` | `writingToolsConfigurationState` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- appActionIfAccountIsClockedOut: polymorphic schema; accepts an untyped value
- appActionIfUnableToAuthenticateUser: polymorphic schema; accepts an untyped value
- apps[].mobileAppIdentifier: polymorphic schema; accepts an untyped value
- assignments[].target: polymorphic schema; accepts an untyped value
- deploymentSummary: polymorphic schema; accepts an untyped value
- genmojiConfigurationState: polymorphic schema; accepts an untyped value
- mobileThreatDefensePartnerPriority: polymorphic schema; accepts an untyped value
- screenCaptureConfigurationState: polymorphic schema; accepts an untyped value
- writingToolsConfigurationState: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
