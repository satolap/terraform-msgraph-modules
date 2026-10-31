# /deviceAppManagement/iosManagedAppProtections

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive inputs: `additional_properties`, `organizationalCredentialsRequired`.
Sensitive outputs: `response`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

Create new navigation property to iosManagedAppProtections for deviceAppManagement

[Catalog](../../README.md) Â· [Device and app management](../../README.md#device-and-app-management) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceAppManagement/iosManagedAppProtections`, `GET/PATCH/DELETE /deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/deviceAppManagement/iosManagedAppProtections"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

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
| `allowWidgetContentSync` | `allowWidgetContentSync` | `bool` | no | no | in place |
| `allowedDataIngestionLocations` | `allowedDataIngestionLocations` | `list(string)` | no | no | in place |
| `allowedDataStorageLocations` | `allowedDataStorageLocations` | `list(string)` | no | no | in place |
| `allowedInboundDataTransferSources` | `allowedInboundDataTransferSources` | `string` | no | no | in place |
| `allowedIosDeviceModels` | `allowedIosDeviceModels` | `string` | no | no | in place |
| `allowedOutboundClipboardSharingExceptionLength` | `allowedOutboundClipboardSharingExceptionLength` | `number` | no | no | in place |
| `allowedOutboundClipboardSharingLevel` | `allowedOutboundClipboardSharingLevel` | `string` | no | no | in place |
| `allowedOutboundDataTransferDestinations` | `allowedOutboundDataTransferDestinations` | `string` | no | no | in place |
| `appActionIfAccountIsClockedOut` | `appActionIfAccountIsClockedOut` | `string` | no | no | in place |
| `appActionIfDeviceComplianceRequired` | `appActionIfDeviceComplianceRequired` | `string` | no | no | in place |
| `appActionIfIosDeviceModelNotAllowed` | `appActionIfIosDeviceModelNotAllowed` | `string` | no | no | in place |
| `appActionIfMaximumPinRetriesExceeded` | `appActionIfMaximumPinRetriesExceeded` | `string` | no | no | in place |
| `appActionIfUnableToAuthenticateUser` | `appActionIfUnableToAuthenticateUser` | `string` | no | no | in place |
| `appDataEncryptionType` | `appDataEncryptionType` | `string` | no | no | in place |
| `appGroupType` | `appGroupType` | `string` | no | no | in place |
| `apps` | `apps` | `list(object({       odata_type = optional(string, "#microsoft.graph.managedMobileApp")       mobileAppIdentifier = optional(any)       version = optional(string)     }))` | no | no | in place |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.targetedManagedAppPolicyAssignment")       source = optional(string)       sourceId = optional(string)       target = optional(any)     }))` | no | no | in place |
| `blockDataIngestionIntoOrganizationDocuments` | `blockDataIngestionIntoOrganizationDocuments` | `bool` | no | no | in place |
| `contactSyncBlocked` | `contactSyncBlocked` | `bool` | no | no | in place |
| `createdDateTime` | `createdDateTime` | `string` | no | no | in place |
| `customBrowserProtocol` | `customBrowserProtocol` | `string` | no | no | in place |
| `customDialerAppProtocol` | `customDialerAppProtocol` | `string` | no | no | in place |
| `dataBackupBlocked` | `dataBackupBlocked` | `bool` | no | no | in place |
| `deployedAppCount` | `deployedAppCount` | `number` | no | no | in place |
| `deploymentSummary` | `deploymentSummary` | `any` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `deviceComplianceRequired` | `deviceComplianceRequired` | `bool` | no | no | in place |
| `dialerRestrictionLevel` | `dialerRestrictionLevel` | `string` | no | no | in place |
| `disableAppPinIfDevicePinIsSet` | `disableAppPinIfDevicePinIsSet` | `bool` | no | no | in place |
| `disableProtectionOfManagedOutboundOpenInData` | `disableProtectionOfManagedOutboundOpenInData` | `bool` | no | no | in place |
| `displayName` | `displayName` | `string` | no | no | in place |
| `exemptedAppProtocols` | `exemptedAppProtocols` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyValuePair")       name = optional(string)       value = optional(string)     }))` | no | no | in place |
| `exemptedUniversalLinks` | `exemptedUniversalLinks` | `list(string)` | no | no | in place |
| `faceIdBlocked` | `faceIdBlocked` | `bool` | no | no | in place |
| `filterOpenInToOnlyManagedApps` | `filterOpenInToOnlyManagedApps` | `bool` | no | no | in place |
| `fingerprintBlocked` | `fingerprintBlocked` | `bool` | no | no | in place |
| `genmojiConfigurationState` | `genmojiConfigurationState` | `string` | no | no | in place |
| `gracePeriodToBlockAppsDuringOffClockHours` | `gracePeriodToBlockAppsDuringOffClockHours` | `string` | no | no | in place |
| `graph_version` | `version` | `string` | no | no | in place |
| `isAssigned` | `isAssigned` | `bool` | no | no | in place |
| `lastModifiedDateTime` | `lastModifiedDateTime` | `string` | no | no | in place |
| `managedBrowser` | `managedBrowser` | `string` | no | no | in place |
| `managedBrowserToOpenLinksRequired` | `managedBrowserToOpenLinksRequired` | `bool` | no | no | in place |
| `managedUniversalLinks` | `managedUniversalLinks` | `list(string)` | no | no | in place |
| `maximumAllowedDeviceThreatLevel` | `maximumAllowedDeviceThreatLevel` | `string` | no | no | in place |
| `maximumPinRetries` | `maximumPinRetries` | `number` | no | no | in place |
| `maximumRequiredOsVersion` | `maximumRequiredOsVersion` | `string` | no | no | in place |
| `maximumWarningOsVersion` | `maximumWarningOsVersion` | `string` | no | no | in place |
| `maximumWipeOsVersion` | `maximumWipeOsVersion` | `string` | no | no | in place |
| `messagingRedirectAppUrlScheme` | `messagingRedirectAppUrlScheme` | `string` | no | no | in place |
| `minimumPinLength` | `minimumPinLength` | `number` | no | no | in place |
| `minimumRequiredAppVersion` | `minimumRequiredAppVersion` | `string` | no | no | in place |
| `minimumRequiredOsVersion` | `minimumRequiredOsVersion` | `string` | no | no | in place |
| `minimumRequiredSdkVersion` | `minimumRequiredSdkVersion` | `string` | no | no | in place |
| `minimumWarningAppVersion` | `minimumWarningAppVersion` | `string` | no | no | in place |
| `minimumWarningOsVersion` | `minimumWarningOsVersion` | `string` | no | no | in place |
| `minimumWarningSdkVersion` | `minimumWarningSdkVersion` | `string` | no | no | in place |
| `minimumWipeAppVersion` | `minimumWipeAppVersion` | `string` | no | no | in place |
| `minimumWipeOsVersion` | `minimumWipeOsVersion` | `string` | no | no | in place |
| `minimumWipeSdkVersion` | `minimumWipeSdkVersion` | `string` | no | no | in place |
| `mobileThreatDefensePartnerPriority` | `mobileThreatDefensePartnerPriority` | `string` | no | no | in place |
| `mobileThreatDefenseRemediationAction` | `mobileThreatDefenseRemediationAction` | `string` | no | no | in place |
| `notificationRestriction` | `notificationRestriction` | `string` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `organizationalCredentialsRequired` | `organizationalCredentialsRequired` | `bool` | no | yes | in place |
| `periodBeforePinReset` | `periodBeforePinReset` | `string` | no | no | in place |
| `periodOfflineBeforeAccessCheck` | `periodOfflineBeforeAccessCheck` | `string` | no | no | in place |
| `periodOfflineBeforeWipeIsEnforced` | `periodOfflineBeforeWipeIsEnforced` | `string` | no | no | in place |
| `periodOnlineBeforeAccessCheck` | `periodOnlineBeforeAccessCheck` | `string` | no | no | in place |
| `pinCharacterSet` | `pinCharacterSet` | `string` | no | no | in place |
| `pinRequired` | `pinRequired` | `bool` | no | no | in place |
| `pinRequiredInsteadOfBiometricTimeout` | `pinRequiredInsteadOfBiometricTimeout` | `string` | no | no | in place |
| `previousPinBlockCount` | `previousPinBlockCount` | `number` | no | no | in place |
| `printBlocked` | `printBlocked` | `bool` | no | no | in place |
| `protectInboundDataFromUnknownSources` | `protectInboundDataFromUnknownSources` | `bool` | no | no | in place |
| `protectedMessagingRedirectAppType` | `protectedMessagingRedirectAppType` | `string` | no | no | in place |
| `purviewContentEvaluationRequired` | `purviewContentEvaluationRequired` | `string` | no | no | in place |
| `roleScopeTagIds` | `roleScopeTagIds` | `list(string)` | no | no | in place |
| `saveAsBlocked` | `saveAsBlocked` | `bool` | no | no | in place |
| `screenCaptureConfigurationState` | `screenCaptureConfigurationState` | `string` | no | no | in place |
| `simplePinBlocked` | `simplePinBlocked` | `bool` | no | no | in place |
| `targetedAppManagementLevels` | `targetedAppManagementLevels` | `string` | no | no | in place |
| `thirdPartyKeyboardsBlocked` | `thirdPartyKeyboardsBlocked` | `bool` | no | no | in place |
| `writingToolsConfigurationState` | `writingToolsConfigurationState` | `string` | no | no | in place |
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

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /deviceAppManagement/iosManagedAppProtections` | DelegatedWork | `DeviceManagementApps.ReadWrite.All` | — |
| `POST /deviceAppManagement/iosManagedAppProtections` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /deviceAppManagement/iosManagedAppProtections` | Application | `DeviceManagementApps.ReadWrite.All` | — |
| `GET /deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}` | DelegatedWork | `DeviceManagementApps.Read.All` | — |
| `GET /deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}` | DelegatedWork | `DeviceManagementApps.ReadWrite.All` | — |
| `GET /deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}` | Application | `DeviceManagementApps.Read.All` | — |
| `GET /deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}` | Application | `DeviceManagementApps.ReadWrite.All` | — |
| `PATCH /deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}` | DelegatedWork | `DeviceManagementApps.ReadWrite.All` | — |
| `PATCH /deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PATCH /deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}` | Application | `DeviceManagementApps.ReadWrite.All` | — |
| `DELETE /deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}` | DelegatedWork | `DeviceManagementApps.ReadWrite.All` | — |
| `DELETE /deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}` | Application | `DeviceManagementApps.ReadWrite.All` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- apps[].mobileAppIdentifier: polymorphic schema; accepts an untyped value
- assignments[].target: polymorphic schema; accepts an untyped value
- deploymentSummary: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
