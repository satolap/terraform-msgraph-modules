# /deviceManagement/mobileThreatDefenseConnectors

Create new navigation property to mobileThreatDefenseConnectors for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-mobilethreatdefenseconnector?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/mobileThreatDefenseConnectors`, `GET/PATCH/DELETE /deviceManagement/mobileThreatDefenseConnectors/{mobileThreatDefenseConnector-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/mobile-threat-defense-connectors"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `allow_partner_to_collect_ios_application_metadata` | `allowPartnerToCollectIOSApplicationMetadata` | `bool` | no | no |
| `allow_partner_to_collect_ios_certificate_metadata` | `allowPartnerToCollectIosCertificateMetadata` | `bool` | no | no |
| `allow_partner_to_collect_ios_personal_application_metadata` | `allowPartnerToCollectIOSPersonalApplicationMetadata` | `bool` | no | no |
| `allow_partner_to_collect_ios_personal_certificate_metadata` | `allowPartnerToCollectIosPersonalCertificateMetadata` | `bool` | no | no |
| `android_device_blocked_on_missing_partner_data` | `androidDeviceBlockedOnMissingPartnerData` | `bool` | no | no |
| `android_enabled` | `androidEnabled` | `bool` | no | no |
| `android_mobile_application_management_enabled` | `androidMobileApplicationManagementEnabled` | `bool` | no | no |
| `grant_mobile_threat_defense_partner_role` | `grantMobileThreatDefensePartnerRole` | `bool` | no | no |
| `ios_device_blocked_on_missing_partner_data` | `iosDeviceBlockedOnMissingPartnerData` | `bool` | no | no |
| `ios_enabled` | `iosEnabled` | `bool` | no | no |
| `ios_mobile_application_management_enabled` | `iosMobileApplicationManagementEnabled` | `bool` | no | no |
| `last_heartbeat_date_time` | `lastHeartbeatDateTime` | `string` | no | no |
| `launch_mobile_threat_defense_partner_on_setup_enabled` | `launchMobileThreatDefensePartnerOnSetupEnabled` | `bool` | no | no |
| `mac_device_blocked_on_missing_partner_data` | `macDeviceBlockedOnMissingPartnerData` | `bool` | no | no |
| `mac_enabled` | `macEnabled` | `bool` | no | no |
| `microsoft_defender_for_endpoint_attach_enabled` | `microsoftDefenderForEndpointAttachEnabled` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `partner_minimum_supported_android_version` | `partnerMinimumSupportedAndroidVersion` | `string` | no | no |
| `partner_minimum_supported_ios_version` | `partnerMinimumSupportedIosVersion` | `string` | no | no |
| `partner_minimum_supported_mac_version` | `partnerMinimumSupportedMacVersion` | `string` | no | no |
| `partner_minimum_supported_windows_version` | `partnerMinimumSupportedWindowsVersion` | `string` | no | no |
| `partner_state` | `partnerState` | `string` | no | no |
| `partner_supports_android_mam` | `partnerSupportsAndroidMam` | `bool` | no | no |
| `partner_supports_ios_certificate_sync` | `partnerSupportsIosCertificateSync` | `bool` | no | no |
| `partner_supports_ios_mam` | `partnerSupportsIosMam` | `bool` | no | no |
| `partner_supports_windows_mam` | `partnerSupportsWindowsMam` | `bool` | no | no |
| `partner_unresponsiveness_threshold_in_days` | `partnerUnresponsivenessThresholdInDays` | `number` | no | no |
| `partner_unsupported_os_version_blocked` | `partnerUnsupportedOsVersionBlocked` | `bool` | no | no |
| `windows_device_blocked_on_missing_partner_data` | `windowsDeviceBlockedOnMissingPartnerData` | `bool` | no | no |
| `windows_enabled` | `windowsEnabled` | `bool` | no | no |
| `windows_mobile_application_management_enabled` | `windowsMobileApplicationManagementEnabled` | `bool` | no | no |
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
