# /policies/conditionalAccessPolicies

Create new navigation property to conditionalAccessPolicies for policies

[Catalog](../../../README.md) · [Identity and access](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/conditionalaccesspolicy?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /policies/conditionalAccessPolicies`, `GET/PATCH/DELETE /policies/conditionalAccessPolicies/{conditionalAccessPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/identity-and-access/policies/conditional-access-policies?ref=<release-tag>"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `conditions` | `conditions` | `object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessConditionSet")       agentContext = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessAgentContext")       excludeAgentContexts = optional(list(string))       includeAgentContexts = optional(list(string))     }))       agentIdRiskLevels = optional(string)       agents = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessAgents")       agentFilter = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessFilter")       mode = optional(string)       rule = optional(string)     }))       excludeAgentUsers = optional(list(string))       includeAgentUsers = optional(list(string))     }))       applications = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessApplications")       applicationFilter = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessFilter")       mode = optional(string)       rule = optional(string)     }))       excludeApplications = optional(list(string))       globalSecureAccess = optional(any)       includeApplications = optional(list(string))       includeAuthenticationContextClassReferences = optional(list(string))       includeUserActions = optional(list(string))       networkAccess = optional(any)     }))       authenticationFlows = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessAuthenticationFlows")       transferMethods = optional(string)     }))       clientAppTypes = optional(list(string))       clientApplications = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessClientApplications")       agentIdServicePrincipalFilter = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessFilter")       mode = optional(string)       rule = optional(string)     }))       excludeAgentIdServicePrincipals = optional(list(string))       excludeServicePrincipals = optional(list(string))       includeAgentIdServicePrincipals = optional(list(string))       includeServicePrincipals = optional(list(string))       servicePrincipalFilter = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessFilter")       mode = optional(string)       rule = optional(string)     }))     }))       deviceStates = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessDeviceStates")       excludeStates = optional(list(string))       includeStates = optional(list(string))     }))       devices = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessDevices")       deviceFilter = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessFilter")       mode = optional(string)       rule = optional(string)     }))       excludeDeviceStates = optional(list(string))       excludeDevices = optional(list(string))       includeDeviceStates = optional(list(string))       includeDevices = optional(list(string))     }))       insiderRiskLevels = optional(string)       locations = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessLocations")       excludeLocations = optional(list(string))       includeLocations = optional(list(string))     }))       platforms = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessPlatforms")       excludePlatforms = optional(list(string))       includePlatforms = optional(list(string))     }))       servicePrincipalRiskLevels = optional(list(string))       signInRiskLevels = optional(list(string))       userRiskLevels = optional(list(string))       users = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessUsers")       excludeGroups = optional(list(string))       excludeGuestsOrExternalUsers = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessGuestsOrExternalUsers")       externalTenants = optional(any)       guestOrExternalUserTypes = optional(string)     }))       excludeRoles = optional(list(string))       excludeUsers = optional(list(string))       includeGroups = optional(list(string))       includeGuestsOrExternalUsers = optional(object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessGuestsOrExternalUsers")       externalTenants = optional(any)       guestOrExternalUserTypes = optional(string)     }))       includeRoles = optional(list(string))       includeUsers = optional(list(string))     }))     })` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `grant_controls` | `grantControls` | `object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessGrantControls")       authenticationStrength = optional(any)       builtInControls = optional(list(string))       customAuthenticationFactors = optional(list(string))       operator = optional(string)       termsOfUse = optional(list(string))     })` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `session_controls` | `sessionControls` | `object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessSessionControls")       applicationEnforcedRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.applicationEnforcedRestrictionsSessionControl")       isEnabled = optional(bool)     }))       cloudAppSecurity = optional(object({       odata_type = optional(string, "#microsoft.graph.cloudAppSecuritySessionControl")       cloudAppSecurityType = optional(string)       isEnabled = optional(bool)     }))       continuousAccessEvaluation = optional(object({       odata_type = optional(string, "#microsoft.graph.continuousAccessEvaluationSessionControl")       mode = optional(string)     }))       disableResilienceDefaults = optional(bool)       globalSecureAccessFilteringProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.globalSecureAccessFilteringProfileSessionControl")       isEnabled = optional(bool)       profileId = optional(string)     }))       persistentBrowser = optional(object({       odata_type = optional(string, "#microsoft.graph.persistentBrowserSessionControl")       isEnabled = optional(bool)       mode = optional(string)     }))       secureSignInSession = optional(object({       odata_type = optional(string, "#microsoft.graph.secureSignInSessionControl")       isEnabled = optional(bool)     }))       signInFrequency = optional(object({       odata_type = optional(string, "#microsoft.graph.signInFrequencySessionControl")       authenticationType = optional(string)       frequencyInterval = optional(string)       isEnabled = optional(bool)       type = optional(string)       value = optional(number)     }))     })` | no | no |
| `state` | `state` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- conditions.applications.globalSecureAccess: polymorphic schema; accepts an untyped value
- conditions.applications.networkAccess: polymorphic schema; accepts an untyped value
- conditions.users.excludeGuestsOrExternalUsers.externalTenants: polymorphic schema; accepts an untyped value
- conditions.users.includeGuestsOrExternalUsers.externalTenants: polymorphic schema; accepts an untyped value
- grantControls.authenticationStrength: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
