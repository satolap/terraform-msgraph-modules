# /policies/appManagementPolicies

Create appManagementPolicy

[Catalog](../../../README.md) · [Applications](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/appmanagementpolicy?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /policies/appManagementPolicies`, `GET/PATCH/DELETE /policies/appManagementPolicies/{appManagementPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./applications/policies/app-management-policies"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `applies_to` | `appliesTo` | `any` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `is_enabled` | `isEnabled` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `restrictions` | `restrictions` | `object({       odata_type = optional(string, "#microsoft.graph.customAppManagementConfiguration")       applicationRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.customAppManagementApplicationConfiguration")       audiences = optional(object({       odata_type = optional(string, "#microsoft.graph.audiencesConfiguration")       azureAdMultipleOrgs = optional(object({       odata_type = optional(string, "#microsoft.graph.azureAdMultipleOrgsAudienceRestriction")       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       restrictForAppsCreatedAfterDateTime = optional(string)       state = optional(string)     }))       personalMicrosoftAccount = optional(any)     }))       identifierUris = optional(object({       odata_type = optional(string, "#microsoft.graph.identifierUriConfiguration")       nonDefaultUriAddition = optional(object({       odata_type = optional(string, "#microsoft.graph.identifierUriRestriction")       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       excludeAppsReceivingV2Tokens = optional(bool)       excludeSaml = optional(bool)       restrictForAppsCreatedAfterDateTime = optional(string)       state = optional(string)     }))       uriAdditionWithoutUniqueTenantIdentifier = optional(object({       odata_type = optional(string, "#microsoft.graph.identifierUriRestriction")       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       excludeAppsReceivingV2Tokens = optional(bool)       excludeSaml = optional(bool)       restrictForAppsCreatedAfterDateTime = optional(string)       state = optional(string)     }))     }))       redirectUris = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriConfiguration")       uriWithBlockedDomain = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriBlockedDomainConfiguration")       blockedDomains = optional(list(string))       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       publicClient = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformBlockedDomainConfiguration")       blockedDomains = optional(any)     }))       restrictForAppsCreatedAfterDateTime = optional(string)       spa = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformBlockedDomainConfiguration")       blockedDomains = optional(any)     }))       state = optional(string)       web = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformBlockedDomainConfiguration")       blockedDomains = optional(any)     }))     }))       uriWithBlockedScheme = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriBlockedSchemeConfiguration")       blockedSchemes = optional(list(string))       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       exemptFormats = optional(list(string))       publicClient = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformBlockedSchemeConfiguration")       blockedSchemes = optional(any)       exemptFormats = optional(any)     }))       restrictForAppsCreatedAfterDateTime = optional(string)       spa = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformBlockedSchemeConfiguration")       blockedSchemes = optional(any)       exemptFormats = optional(any)     }))       state = optional(string)       web = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformBlockedSchemeConfiguration")       blockedSchemes = optional(any)       exemptFormats = optional(any)     }))     }))       uriWithWildcard = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriWildcardConfiguration")       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       excludeFormats = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriWildcardExcludeFormats")       excludeWildcardsInPath = optional(bool)       excludeWildcardsInPathWithDomains = optional(any)     }))       restrictForAppsCreatedAfterDateTime = optional(string)       state = optional(string)     }))       uriWithoutAllowedDomain = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriAllowedDomainConfiguration")       allowedDomains = optional(list(string))       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       publicClient = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformAllowedDomainConfiguration")       allowedDomains = optional(any)     }))       restrictForAppsCreatedAfterDateTime = optional(string)       spa = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformAllowedDomainConfiguration")       allowedDomains = optional(any)     }))       state = optional(string)       web = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformAllowedDomainConfiguration")       allowedDomains = optional(any)     }))     }))       uriWithoutAllowedScheme = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriAllowedSchemeConfiguration")       allowedSchemes = optional(list(string))       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       publicClient = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformAllowedSchemeConfiguration")       allowedSchemes = optional(any)     }))       restrictForAppsCreatedAfterDateTime = optional(string)       spa = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformAllowedSchemeConfiguration")       allowedSchemes = optional(any)     }))       state = optional(string)       web = optional(object({       odata_type = optional(string, "#microsoft.graph.redirectUriPlatformAllowedSchemeConfiguration")       allowedSchemes = optional(any)     }))     }))     }))     }))       keyCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyCredentialConfiguration")       certificateBasedApplicationConfigurationIds = optional(list(string))       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       maxLifetime = optional(string)       restrictForAppsCreatedAfterDateTime = optional(string)       restrictionType = optional(string)       state = optional(string)     })))       passwordCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredentialConfiguration")       excludeActors = optional(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicyActorExemptions")       customSecurityAttributes = optional(any)     }))       maxLifetime = optional(string)       restrictForAppsCreatedAfterDateTime = optional(string)       restrictionType = optional(string)       state = optional(string)     })))     })` | no | yes |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- appliesTo[]: polymorphic schema; accepts an untyped value
- restrictions.applicationRestrictions.audiences.azureAdMultipleOrgs.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.audiences.personalMicrosoftAccount: polymorphic schema; accepts an untyped value
- restrictions.applicationRestrictions.identifierUris.nonDefaultUriAddition.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.identifierUris.uriAdditionWithoutUniqueTenantIdentifier.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedDomain.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedDomain.publicClient.blockedDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedDomain.spa.blockedDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedDomain.web.blockedDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.publicClient.blockedSchemes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.publicClient.exemptFormats: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.spa.blockedSchemes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.spa.exemptFormats: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.web.blockedSchemes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithBlockedScheme.web.exemptFormats: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithWildcard.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithWildcard.excludeFormats.excludeWildcardsInPathWithDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedDomain.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedDomain.publicClient.allowedDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedDomain.spa.allowedDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedDomain.web.allowedDomains: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedScheme.excludeActors.customSecurityAttributes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedScheme.publicClient.allowedSchemes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedScheme.spa.allowedSchemes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.applicationRestrictions.redirectUris.uriWithoutAllowedScheme.web.allowedSchemes: nested schema exceeds depth limit; accepts an untyped value
- restrictions.keyCredentials[].excludeActors.customSecurityAttributes[]: nested schema exceeds depth limit; accepts an untyped value
- restrictions.passwordCredentials[].excludeActors.customSecurityAttributes[]: nested schema exceeds depth limit; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
