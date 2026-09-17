# /deviceManagement/depOnboardingSettings/{depOnboardingSetting-id}/enrollmentProfiles

Create new navigation property to enrollmentProfiles for deviceManagement

[Catalog](../../../../../README.md) · [Device and app management](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-enrollment-enrollmentprofile?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/depOnboardingSettings/{depOnboardingSetting-id}/enrollmentProfiles`, `GET/PATCH/DELETE /deviceManagement/depOnboardingSettings/{depOnboardingSetting-id}/enrollmentProfiles/{enrollmentProfile-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/dep-onboarding-settings/by-dep-onboarding-setting-id/enrollment-profiles"
  dep_onboarding_setting_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `dep_onboarding_setting_id` | URL parameter `depOnboardingSetting-id` | `string` | yes | no |
| `configuration_endpoint_url` | `configurationEndpointUrl` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `enable_authentication_via_company_portal` | `enableAuthenticationViaCompanyPortal` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `require_company_portal_on_setup_assistant_enrolled_devices` | `requireCompanyPortalOnSetupAssistantEnrolledDevices` | `bool` | no | no |
| `requires_user_authentication` | `requiresUserAuthentication` | `bool` | no | no |
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
