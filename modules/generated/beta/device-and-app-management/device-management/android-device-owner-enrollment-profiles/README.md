# /deviceManagement/androidDeviceOwnerEnrollmentProfiles

Create new navigation property to androidDeviceOwnerEnrollmentProfiles for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-androidforwork-androiddeviceownerenrollmentprofile?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/androidDeviceOwnerEnrollmentProfiles`, `GET/PATCH/DELETE /deviceManagement/androidDeviceOwnerEnrollmentProfiles/{androidDeviceOwnerEnrollmentProfile-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/android-device-owner-enrollment-profiles"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `account_id` | `accountId` | `string` | no | no |
| `configure_wifi` | `configureWifi` | `bool` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `device_name_template` | `deviceNameTemplate` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `enrolled_device_count` | `enrolledDeviceCount` | `number` | no | no |
| `enrollment_mode` | `enrollmentMode` | `string` | no | no |
| `enrollment_token_type` | `enrollmentTokenType` | `string` | no | no |
| `enrollment_token_usage_count` | `enrollmentTokenUsageCount` | `number` | no | no |
| `is_teams_device_profile` | `isTeamsDeviceProfile` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `qr_code_content` | `qrCodeContent` | `string` | no | no |
| `qr_code_image` | `qrCodeImage` | `any` | no | no |
| `role_scope_tag_ids` | `roleScopeTagIds` | `list(string)` | no | no |
| `token_creation_date_time` | `tokenCreationDateTime` | `string` | no | no |
| `token_expiration_date_time` | `tokenExpirationDateTime` | `string` | no | no |
| `token_value` | `tokenValue` | `string` | no | no |
| `wifi_hidden` | `wifiHidden` | `bool` | no | no |
| `wifi_password` | `wifiPassword` | `string` | no | yes |
| `wifi_security_type` | `wifiSecurityType` | `string` | no | no |
| `wifi_ssid` | `wifiSsid` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- qrCodeImage: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
