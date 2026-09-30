# /organization/{organization-id}/branding/localizations

Create organizationalBrandingLocalization

[Catalog](../../../../../README.md) · [Identity and access](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/organizationalbrandinglocalization?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /organization/{organization-id}/branding/localizations`, `GET/PATCH/DELETE /organization/{organization-id}/branding/localizations/{organizationalBrandingLocalization-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/identity-and-access/organization/by-organization-id/branding/localizations?ref=<release-tag>"
  organization_id = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `organization_id` | URL parameter `organization-id` | `string` | yes | no |
| `background_color` | `backgroundColor` | `string` | no | no |
| `background_image` | `backgroundImage` | `string` | no | no |
| `banner_logo` | `bannerLogo` | `string` | no | no |
| `content_customization` | `contentCustomization` | `object({       odata_type = optional(string, "#microsoft.graph.contentCustomization")       attributeCollection = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     })))       attributeCollectionRelativeUrl = optional(string)       registrationCampaign = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     })))       registrationCampaignRelativeUrl = optional(string)     })` | no | no |
| `custom_account_reset_credentials_url` | `customAccountResetCredentialsUrl` | `string` | no | yes |
| `custom_cannot_access_your_account_text` | `customCannotAccessYourAccountText` | `string` | no | no |
| `custom_cannot_access_your_account_url` | `customCannotAccessYourAccountUrl` | `string` | no | no |
| `custom_css` | `customCSS` | `string` | no | no |
| `custom_forgot_my_password_text` | `customForgotMyPasswordText` | `string` | no | yes |
| `custom_privacy_and_cookies_text` | `customPrivacyAndCookiesText` | `string` | no | no |
| `custom_privacy_and_cookies_url` | `customPrivacyAndCookiesUrl` | `string` | no | no |
| `custom_reset_it_now_text` | `customResetItNowText` | `string` | no | no |
| `custom_terms_of_use_text` | `customTermsOfUseText` | `string` | no | no |
| `custom_terms_of_use_url` | `customTermsOfUseUrl` | `string` | no | no |
| `favicon` | `favicon` | `string` | no | no |
| `header_background_color` | `headerBackgroundColor` | `string` | no | no |
| `header_logo` | `headerLogo` | `string` | no | no |
| `login_page_layout_configuration` | `loginPageLayoutConfiguration` | `object({       odata_type = optional(string, "#microsoft.graph.loginPageLayoutConfiguration")       isFooterShown = optional(bool)       isHeaderShown = optional(bool)       layoutTemplateType = optional(string)     })` | no | no |
| `login_page_text_visibility_settings` | `loginPageTextVisibilitySettings` | `object({       odata_type = optional(string, "#microsoft.graph.loginPageTextVisibilitySettings")       hideAccountResetCredentials = optional(bool)       hideCannotAccessYourAccount = optional(bool)       hideForgotMyPassword = optional(bool)       hidePrivacyAndCookies = optional(bool)       hideResetItNow = optional(bool)       hideTermsOfUse = optional(bool)     })` | no | yes |
| `odata_type` | `@odata.type` | `string` | no | no |
| `sign_in_page_text` | `signInPageText` | `string` | no | no |
| `square_logo` | `squareLogo` | `string` | no | no |
| `square_logo_dark` | `squareLogoDark` | `string` | no | no |
| `username_hint_text` | `usernameHintText` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
