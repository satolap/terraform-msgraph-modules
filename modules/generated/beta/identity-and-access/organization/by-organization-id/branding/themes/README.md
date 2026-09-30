# /organization/{organization-id}/branding/themes

Create organizationalBrandingTheme

[Catalog](../../../../../README.md) · [Identity and access](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/organizationalbrandingtheme?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /organization/{organization-id}/branding/themes`, `GET/PATCH/DELETE /organization/{organization-id}/branding/themes/{organizationalBrandingTheme-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/identity-and-access/organization/by-organization-id/branding/themes?ref=<release-tag>"
  organization_id = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `organization_id` | URL parameter `organization-id` | `string` | yes | no |
| `is_default_theme` | `isDefaultTheme` | `bool` | no | no |
| `localizations` | `localizations` | `list(object({       odata_type = optional(string, "#microsoft.graph.organizationalBrandingThemeLocalization")       accountResetCredentials = optional(object({       odata_type = optional(string, "#microsoft.graph.loginPageBrandingVisualElement")       customText = optional(string)       customUrl = optional(string)       isHidden = optional(bool)     }))       backgroundImage = optional(string)       bannerLogo = optional(string)       cannotAccessYourAccount = optional(object({       odata_type = optional(string, "#microsoft.graph.loginPageBrandingVisualElement")       customText = optional(string)       customUrl = optional(string)       isHidden = optional(bool)     }))       contentCustomization = optional(object({       odata_type = optional(string, "#microsoft.graph.contentCustomization")       attributeCollection = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     })))       attributeCollectionRelativeUrl = optional(string)       registrationCampaign = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     })))       registrationCampaignRelativeUrl = optional(string)     }))       customCSS = optional(string)       favicon = optional(string)       forgotMyPassword = optional(object({       odata_type = optional(string, "#microsoft.graph.loginPageBrandingVisualElement")       customText = optional(string)       customUrl = optional(string)       isHidden = optional(bool)     }))       headerBackgroundColor = optional(string)       headerLogo = optional(string)       locale = optional(string)       loginPageLayoutConfiguration = optional(object({       odata_type = optional(string, "#microsoft.graph.loginPageLayoutConfiguration")       isFooterShown = optional(bool)       isHeaderShown = optional(bool)       layoutTemplateType = optional(string)     }))       pageBackgroundColor = optional(string)       privacyAndCookies = optional(object({       odata_type = optional(string, "#microsoft.graph.loginPageBrandingVisualElement")       customText = optional(string)       customUrl = optional(string)       isHidden = optional(bool)     }))       resetItNow = optional(object({       odata_type = optional(string, "#microsoft.graph.loginPageBrandingVisualElement")       customText = optional(string)       customUrl = optional(string)       isHidden = optional(bool)     }))       signInPageText = optional(string)       squareLogo = optional(string)       squareLogoDark = optional(string)       termsOfUse = optional(object({       odata_type = optional(string, "#microsoft.graph.loginPageBrandingVisualElement")       customText = optional(string)       customUrl = optional(string)       isHidden = optional(bool)     }))       usernameHintText = optional(string)     }))` | no | yes |
| `name` | `name` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
