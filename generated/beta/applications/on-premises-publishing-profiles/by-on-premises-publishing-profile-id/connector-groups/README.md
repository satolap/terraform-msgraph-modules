# /onPremisesPublishingProfiles/{onPremisesPublishingProfile-id}/connectorGroups

Create new navigation property to connectorGroups for onPremisesPublishingProfiles

[Catalog](../../../../README.md) · [Applications](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/connectorgroup?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /onPremisesPublishingProfiles/{onPremisesPublishingProfile-id}/connectorGroups`, `GET/PATCH/DELETE /onPremisesPublishingProfiles/{onPremisesPublishingProfile-id}/connectorGroups/{connectorGroup-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./applications/on-premises-publishing-profiles/by-on-premises-publishing-profile-id/connector-groups"
  on_premises_publishing_profile_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `on_premises_publishing_profile_id` | URL parameter `onPremisesPublishingProfile-id` | `string` | yes | no |
| `applications` | `applications` | `list(object({       odata_type = optional(string, "#microsoft.graph.application")       api = optional(any)       appManagementPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicy")       appliesTo = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isEnabled = optional(bool)       restrictions = optional(any)     })))       appRoles = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRole")       allowedMemberTypes = optional(list(string))       description = optional(string)       displayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       value = optional(string)     })))       authenticationBehaviors = optional(any)       certification = optional(any)       connectorGroup = optional(any)       defaultRedirectUri = optional(string)       deletedDateTime = optional(string)       description = optional(string)       disabledByMicrosoftStatus = optional(string)       displayName = optional(string)       federatedIdentityCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.federatedIdentityCredential")       audiences = optional(list(string))       claimsMatchingExpression = optional(any)       description = optional(string)       issuer = optional(string)       name = optional(string)       subject = optional(string)     })))       groupMembershipClaims = optional(string)       homeRealmDiscoveryPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.homeRealmDiscoveryPolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     })))       identifierUris = optional(list(string))       info = optional(any)       isDeviceOnlyAuthSupported = optional(bool)       isDisabled = optional(bool)       isFallbackPublicClient = optional(bool)       keyCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       key = optional(string)       keyId = optional(string)       startDateTime = optional(string)       type = optional(string)       usage = optional(string)     })))       logo = optional(string)       nativeAuthenticationApisEnabled = optional(any)       notes = optional(string)       onPremisesPublishing = optional(any)       optionalClaims = optional(any)       parentalControlSettings = optional(any)       passwordCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       keyId = optional(string)       startDateTime = optional(string)     })))       publicClient = optional(any)       requestSignatureVerification = optional(any)       requiredResourceAccess = optional(list(object({       odata_type = optional(string, "#microsoft.graph.requiredResourceAccess")       resourceAccess = optional(any)       resourceAppId = optional(string)     })))       samlMetadataUrl = optional(string)       serviceManagementReference = optional(string)       servicePrincipalLockConfiguration = optional(any)       signInAudience = optional(string)       signInAudienceRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.signInAudienceRestrictionsBase")       kind = optional(string)     }))       spa = optional(any)       synchronization = optional(any)       tags = optional(list(string))       tokenEncryptionKeyId = optional(string)       tokenIssuancePolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.tokenIssuancePolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     })))       tokenLifetimePolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.tokenLifetimePolicy")       appliesTo = optional(any)       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     })))       verifiedPublisher = optional(any)       web = optional(any)       windows = optional(any)     }))` | no | yes |
| `connector_group_type` | `connectorGroupType` | `string` | no | no |
| `members` | `members` | `list(object({       odata_type = optional(string, "#microsoft.graph.connector")       machineName = optional(string)       status = optional(string)     }))` | no | no |
| `name` | `name` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `region` | `region` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- applications[].api: polymorphic schema; accepts an untyped value
- applications[].appManagementPolicies[].appliesTo[]: nested schema exceeds depth limit; accepts an untyped value
- applications[].appManagementPolicies[].restrictions: polymorphic schema; accepts an untyped value
- applications[].authenticationBehaviors: polymorphic schema; accepts an untyped value
- applications[].certification: polymorphic schema; accepts an untyped value
- applications[].connectorGroup: polymorphic schema; accepts an untyped value
- applications[].federatedIdentityCredentials[].claimsMatchingExpression: polymorphic schema; accepts an untyped value
- applications[].homeRealmDiscoveryPolicies[].appliesTo[]: nested schema exceeds depth limit; accepts an untyped value
- applications[].info: polymorphic schema; accepts an untyped value
- applications[].nativeAuthenticationApisEnabled: polymorphic schema; accepts an untyped value
- applications[].onPremisesPublishing: polymorphic schema; accepts an untyped value
- applications[].optionalClaims: polymorphic schema; accepts an untyped value
- applications[].parentalControlSettings: polymorphic schema; accepts an untyped value
- applications[].publicClient: polymorphic schema; accepts an untyped value
- applications[].requestSignatureVerification: polymorphic schema; accepts an untyped value
- applications[].requiredResourceAccess[].resourceAccess[]: nested schema exceeds depth limit; accepts an untyped value
- applications[].servicePrincipalLockConfiguration: polymorphic schema; accepts an untyped value
- applications[].spa: polymorphic schema; accepts an untyped value
- applications[].synchronization: polymorphic schema; accepts an untyped value
- applications[].tokenIssuancePolicies[].appliesTo[]: nested schema exceeds depth limit; accepts an untyped value
- applications[].tokenLifetimePolicies[].appliesTo[]: nested schema exceeds depth limit; accepts an untyped value
- applications[].verifiedPublisher: polymorphic schema; accepts an untyped value
- applications[].web: polymorphic schema; accepts an untyped value
- applications[].windows: polymorphic schema; accepts an untyped value
- region: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
