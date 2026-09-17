# /deviceManagement/intuneBrandingProfiles

Create new navigation property to intuneBrandingProfiles for deviceManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-wip-intunebrandingprofile?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/intuneBrandingProfiles`, `GET/PATCH/DELETE /deviceManagement/intuneBrandingProfiles/{intuneBrandingProfile-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/intune-branding-profiles"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.intuneBrandingProfileAssignment")       target = optional(any)     }))` | no | no |
| `company_portal_blocked_actions` | `companyPortalBlockedActions` | `list(object({       odata_type = optional(string, "#microsoft.graph.companyPortalBlockedAction")       action = optional(string)       ownerType = optional(string)       platform = optional(string)     }))` | no | no |
| `contact_it_email_address` | `contactITEmailAddress` | `string` | no | no |
| `contact_it_name` | `contactITName` | `string` | no | no |
| `contact_it_notes` | `contactITNotes` | `string` | no | no |
| `contact_it_phone_number` | `contactITPhoneNumber` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `custom_can_see_privacy_message` | `customCanSeePrivacyMessage` | `string` | no | no |
| `custom_cant_see_privacy_message` | `customCantSeePrivacyMessage` | `string` | no | no |
| `custom_privacy_message` | `customPrivacyMessage` | `string` | no | no |
| `disable_client_telemetry` | `disableClientTelemetry` | `bool` | no | no |
| `disable_device_category_selection` | `disableDeviceCategorySelection` | `bool` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `enrollment_availability` | `enrollmentAvailability` | `string` | no | no |
| `is_default_profile` | `isDefaultProfile` | `bool` | no | no |
| `is_factory_reset_disabled` | `isFactoryResetDisabled` | `bool` | no | no |
| `is_remove_device_disabled` | `isRemoveDeviceDisabled` | `bool` | no | no |
| `landing_page_customized_image` | `landingPageCustomizedImage` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `light_background_logo` | `lightBackgroundLogo` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `online_support_site_name` | `onlineSupportSiteName` | `string` | no | no |
| `online_support_site_url` | `onlineSupportSiteUrl` | `string` | no | no |
| `privacy_url` | `privacyUrl` | `string` | no | no |
| `profile_description` | `profileDescription` | `string` | no | no |
| `profile_name` | `profileName` | `string` | no | no |
| `role_scope_tag_ids` | `roleScopeTagIds` | `list(string)` | no | no |
| `show_azure_ad_enterprise_apps` | `showAzureADEnterpriseApps` | `bool` | no | no |
| `show_configuration_manager_apps` | `showConfigurationManagerApps` | `bool` | no | no |
| `show_display_name_next_to_logo` | `showDisplayNameNextToLogo` | `bool` | no | no |
| `show_logo` | `showLogo` | `bool` | no | no |
| `show_office_web_apps` | `showOfficeWebApps` | `bool` | no | no |
| `theme_color` | `themeColor` | `any` | no | no |
| `theme_color_logo` | `themeColorLogo` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- assignments[].target: polymorphic schema; accepts an untyped value
- landingPageCustomizedImage: polymorphic schema; accepts an untyped value
- lightBackgroundLogo: polymorphic schema; accepts an untyped value
- themeColor: polymorphic schema; accepts an untyped value
- themeColorLogo: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
