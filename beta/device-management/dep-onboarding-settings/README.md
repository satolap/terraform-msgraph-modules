# /deviceManagement/depOnboardingSettings

Create new navigation property to depOnboardingSettings for deviceManagement

[Catalog](../../README.md) · [Device and app management](../../README.md#device-and-app-management) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-enrollment-deponboardingsetting?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/depOnboardingSettings`, `GET/PATCH/DELETE /deviceManagement/depOnboardingSettings/{depOnboardingSetting-id}`.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/device-management/dep-onboarding-settings"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `apple_identifier` | `appleIdentifier` | `string` | no | no |
| `data_sharing_consent_granted` | `dataSharingConsentGranted` | `bool` | no | no |
| `default_ios_enrollment_profile` | `defaultIosEnrollmentProfile` | `any` | no | no |
| `default_mac_os_enrollment_profile` | `defaultMacOsEnrollmentProfile` | `any` | no | no |
| `default_tv_os_enrollment_profile` | `defaultTvOSEnrollmentProfile` | `any` | no | no |
| `default_vision_os_enrollment_profile` | `defaultVisionOSEnrollmentProfile` | `any` | no | no |
| `enrollment_profiles` | `enrollmentProfiles` | `any` | no | no |
| `imported_apple_device_identities` | `importedAppleDeviceIdentities` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `last_successful_sync_date_time` | `lastSuccessfulSyncDateTime` | `string` | no | no |
| `last_sync_error_code` | `lastSyncErrorCode` | `number` | no | no |
| `last_sync_triggered_date_time` | `lastSyncTriggeredDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `role_scope_tag_ids` | `roleScopeTagIds` | `list(string)` | no | no |
| `share_token_with_school_data_sync_service` | `shareTokenWithSchoolDataSyncService` | `bool` | no | no |
| `synced_device_count` | `syncedDeviceCount` | `number` | no | no |
| `token_expiration_date_time` | `tokenExpirationDateTime` | `string` | no | no |
| `token_name` | `tokenName` | `string` | no | no |
| `token_type` | `tokenType` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- defaultIosEnrollmentProfile: navigation property; accepts an untyped value
- defaultMacOsEnrollmentProfile: navigation property; accepts an untyped value
- defaultTvOSEnrollmentProfile: navigation property; accepts an untyped value
- defaultVisionOSEnrollmentProfile: navigation property; accepts an untyped value
- enrollmentProfiles[]: polymorphic schema; accepts an untyped value
- importedAppleDeviceIdentities[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
