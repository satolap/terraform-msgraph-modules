# /networkAccess/connectivity/branches/{branchSite-id}/forwardingProfiles

Create new navigation property to forwardingProfiles for networkAccess

[Catalog](../../../../../../README.md) · [Identity and access](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/networkaccess-forwardingprofile?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /networkAccess/connectivity/branches/{branchSite-id}/forwardingProfiles`, `GET/PATCH/DELETE /networkAccess/connectivity/branches/{branchSite-id}/forwardingProfiles/{forwardingProfile-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/network-access/connectivity/branches/by-branch-site-id/forwarding-profiles"
  branch_site_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `branch_site_id` | URL parameter `branchSite-id` | `string` | yes | no |
| `associations` | `associations` | `list(object({       odata_type = optional(string, "#microsoft.graph.networkaccess.association")     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `graph_version` | `version` | `string` | no | no |
| `is_custom_profile` | `isCustomProfile` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `name` | `name` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `policies` | `policies` | `list(object({       odata_type = optional(string, "#microsoft.graph.networkaccess.policyLink")       policy = optional(object({       odata_type = optional(string, "#microsoft.graph.networkaccess.policy")       description = optional(string)       name = optional(string)       policyRules = optional(list(object({       odata_type = optional(string, "#microsoft.graph.networkaccess.policyRule")       name = optional(string)     })))       version = optional(string)     }))       state = optional(string)       version = optional(string)     }))` | no | no |
| `priority` | `priority` | `number` | no | no |
| `service_principal` | `servicePrincipal` | `object({       odata_type = optional(string, "#microsoft.graph.servicePrincipal")       accountEnabled = optional(bool)       addIns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.addIn")       id = optional(string)       properties = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     })))       type = optional(string)     })))       alternativeNames = optional(list(string))       appDescription = optional(string)       appDisplayName = optional(string)       appId = optional(string)       appManagementPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isEnabled = optional(bool)       restrictions = optional(any)     })))       appOwnerOrganizationId = optional(string)       appRoleAssignedTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       appRoleAssignmentRequired = optional(bool)       appRoleAssignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     })))       appRoles = optional(list(object({       odata_type = optional(string, "#microsoft.graph.appRole")       allowedMemberTypes = optional(list(string))       description = optional(string)       displayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       value = optional(string)     })))       claimsMappingPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.claimsMappingPolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     })))       claimsPolicy = optional(any)       customSecurityAttributes = optional(any)       delegatedPermissionClassifications = optional(list(object({       odata_type = optional(string, "#microsoft.graph.delegatedPermissionClassification")       classification = optional(any)       permissionId = optional(string)       permissionName = optional(string)     })))       deletedDateTime = optional(string)       description = optional(string)       disabledByMicrosoftStatus = optional(string)       displayName = optional(string)       endpoints = optional(list(object({       odata_type = optional(string, "#microsoft.graph.endpoint")       deletedDateTime = optional(string)     })))       errorUrl = optional(string)       federatedIdentityCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.federatedIdentityCredential")       audiences = optional(list(string))       claimsMatchingExpression = optional(any)       description = optional(string)       issuer = optional(string)       name = optional(string)       subject = optional(string)     })))       homeRealmDiscoveryPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.homeRealmDiscoveryPolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     })))       homepage = optional(string)       info = optional(any)       isDisabled = optional(bool)       keyCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       key = optional(string)       keyId = optional(string)       startDateTime = optional(string)       type = optional(string)       usage = optional(string)     })))       licenseDetails = optional(list(object({       odata_type = optional(string, "#microsoft.graph.licenseDetails")     })))       loginUrl = optional(string)       logoutUrl = optional(string)       notes = optional(string)       notificationEmailAddresses = optional(list(string))       owners = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       passwordCredentials = optional(list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       keyId = optional(string)       startDateTime = optional(string)     })))       permissionGrantPreApprovalPolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permissionGrantPreApprovalPolicy")       conditions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.preApprovalDetail")       permissions = optional(any)       scopeType = optional(string)       sensitivityLabels = optional(any)     })))       deletedDateTime = optional(string)     })))       preferredSingleSignOnMode = optional(string)       preferredTokenSigningKeyEndDateTime = optional(string)       preferredTokenSigningKeyThumbprint = optional(string)       publishedPermissionScopes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permissionScope")       adminConsentDescription = optional(string)       adminConsentDisplayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       origin = optional(string)       type = optional(string)       userConsentDescription = optional(string)       userConsentDisplayName = optional(string)       value = optional(string)     })))       publisherName = optional(string)       remoteDesktopSecurityConfiguration = optional(any)       replyUrls = optional(list(string))       samlMetadataUrl = optional(string)       samlSingleSignOnSettings = optional(any)       servicePrincipalNames = optional(list(string))       servicePrincipalType = optional(string)       synchronization = optional(any)       tags = optional(list(string))       tokenEncryptionKeyId = optional(string)       tokenIssuancePolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.tokenIssuancePolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     })))       tokenLifetimePolicies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.tokenLifetimePolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     })))       transitiveMemberOf = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       verifiedPublisher = optional(any)     })` | no | yes |
| `state` | `state` | `string` | no | no |
| `traffic_forwarding_type` | `trafficForwardingType` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- servicePrincipal.appManagementPolicies[].restrictions: polymorphic schema; accepts an untyped value
- servicePrincipal.claimsPolicy: polymorphic schema; accepts an untyped value
- servicePrincipal.customSecurityAttributes: polymorphic schema; accepts an untyped value
- servicePrincipal.delegatedPermissionClassifications[].classification: polymorphic schema; accepts an untyped value
- servicePrincipal.federatedIdentityCredentials[].claimsMatchingExpression: polymorphic schema; accepts an untyped value
- servicePrincipal.info: polymorphic schema; accepts an untyped value
- servicePrincipal.permissionGrantPreApprovalPolicies[].conditions[].permissions: nested schema exceeds depth limit; accepts an untyped value
- servicePrincipal.permissionGrantPreApprovalPolicies[].conditions[].sensitivityLabels: nested schema exceeds depth limit; accepts an untyped value
- servicePrincipal.remoteDesktopSecurityConfiguration: polymorphic schema; accepts an untyped value
- servicePrincipal.samlSingleSignOnSettings: polymorphic schema; accepts an untyped value
- servicePrincipal.synchronization: polymorphic schema; accepts an untyped value
- servicePrincipal.verifiedPublisher: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
