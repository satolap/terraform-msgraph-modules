# /deviceManagement/intuneBrandingProfiles

Create new navigation property to intuneBrandingProfiles for deviceManagement

[Catalog](../../README.md) Â· [Device and app management](../../README.md#device-and-app-management) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-wip-intunebrandingprofile?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/intuneBrandingProfiles`, `GET/PATCH/DELETE /deviceManagement/intuneBrandingProfiles/{intuneBrandingProfile-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/device-management/intune-branding-profiles"
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
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.intuneBrandingProfileAssignment")       target = optional(any)     }))` | no | no | in place |
| `company_portal_blocked_actions` | `companyPortalBlockedActions` | `list(object({       odata_type = optional(string, "#microsoft.graph.companyPortalBlockedAction")       action = optional(string)       ownerType = optional(string)       platform = optional(string)     }))` | no | no | in place |
| `contact_it_email_address` | `contactITEmailAddress` | `string` | no | no | in place |
| `contact_it_name` | `contactITName` | `string` | no | no | in place |
| `contact_it_notes` | `contactITNotes` | `string` | no | no | in place |
| `contact_it_phone_number` | `contactITPhoneNumber` | `string` | no | no | in place |
| `created_date_time` | `createdDateTime` | `string` | no | no | in place |
| `custom_can_see_privacy_message` | `customCanSeePrivacyMessage` | `string` | no | no | in place |
| `custom_cant_see_privacy_message` | `customCantSeePrivacyMessage` | `string` | no | no | in place |
| `custom_privacy_message` | `customPrivacyMessage` | `string` | no | no | in place |
| `disable_client_telemetry` | `disableClientTelemetry` | `bool` | no | no | in place |
| `disable_device_category_selection` | `disableDeviceCategorySelection` | `bool` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `enrollment_availability` | `enrollmentAvailability` | `string` | no | no | in place |
| `is_default_profile` | `isDefaultProfile` | `bool` | no | no | in place |
| `is_factory_reset_disabled` | `isFactoryResetDisabled` | `bool` | no | no | in place |
| `is_remove_device_disabled` | `isRemoveDeviceDisabled` | `bool` | no | no | in place |
| `landing_page_customized_image` | `landingPageCustomizedImage` | `object({       odata_type = optional(string, "#microsoft.graph.mimeContent")       type = optional(string)       value = optional(string)     })` | no | no | in place |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no | in place |
| `light_background_logo` | `lightBackgroundLogo` | `object({       odata_type = optional(string, "#microsoft.graph.mimeContent")       type = optional(string)       value = optional(string)     })` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `online_support_site_name` | `onlineSupportSiteName` | `string` | no | no | in place |
| `online_support_site_url` | `onlineSupportSiteUrl` | `string` | no | no | in place |
| `privacy_url` | `privacyUrl` | `string` | no | no | in place |
| `profile_description` | `profileDescription` | `string` | no | no | in place |
| `profile_name` | `profileName` | `string` | no | no | in place |
| `role_scope_tag_ids` | `roleScopeTagIds` | `list(string)` | no | no | in place |
| `show_azure_ad_enterprise_apps` | `showAzureADEnterpriseApps` | `bool` | no | no | in place |
| `show_configuration_manager_apps` | `showConfigurationManagerApps` | `bool` | no | no | in place |
| `show_display_name_next_to_logo` | `showDisplayNameNextToLogo` | `bool` | no | no | in place |
| `show_logo` | `showLogo` | `bool` | no | no | in place |
| `show_office_web_apps` | `showOfficeWebApps` | `bool` | no | no | in place |
| `theme_color` | `themeColor` | `object({       odata_type = optional(string, "#microsoft.graph.rgbColor")       b = optional(number)       g = optional(number)       r = optional(number)     })` | no | no | in place |
| `theme_color_logo` | `themeColorLogo` | `object({       odata_type = optional(string, "#microsoft.graph.mimeContent")       type = optional(string)       value = optional(string)     })` | no | no | in place |
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

- Microsoft Graph beta contracts can change without notice.
- assignments[].target: polymorphic schema; accepts an untyped value
- companyPortalBlockedActions[].platform: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: windowsMobileApplicationManagement; excluded from typed input validation

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
