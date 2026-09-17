# /servicePrincipals

Create servicePrincipal

[Catalog](../../README.md) · [Applications](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/serviceprincipal?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /servicePrincipals`, `GET/PATCH/DELETE /servicePrincipals/{servicePrincipal-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./applications/service-principals"
  app_id = "example"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `app_id` | `appId` | `string` | yes | no |
| `account_enabled` | `accountEnabled` | `bool` | no | no |
| `add_ins` | `addIns` | `list(object({       odata_type = optional(string, "#microsoft.graph.addIn")       id = optional(string)       properties = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     })))       type = optional(string)     }))` | no | no |
| `alternative_names` | `alternativeNames` | `list(string)` | no | no |
| `app_description` | `appDescription` | `string` | no | no |
| `app_display_name` | `appDisplayName` | `string` | no | no |
| `app_management_policies` | `appManagementPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isEnabled = optional(bool)       restrictions = optional(any)     }))` | no | no |
| `app_owner_organization_id` | `appOwnerOrganizationId` | `string` | no | no |
| `app_role_assigned_to` | `appRoleAssignedTo` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     }))` | no | no |
| `app_role_assignment_required` | `appRoleAssignmentRequired` | `bool` | no | no |
| `app_role_assignments` | `appRoleAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRoleAssignment")       appRoleId = optional(string)       deletedDateTime = optional(string)       principalId = optional(string)       resourceDisplayName = optional(string)       resourceId = optional(string)     }))` | no | no |
| `app_roles` | `appRoles` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRole")       allowedMemberTypes = optional(list(string))       description = optional(string)       displayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       value = optional(string)     }))` | no | no |
| `claims_mapping_policies` | `claimsMappingPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.claimsMappingPolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `custom_security_attributes` | `customSecurityAttributes` | `any` | no | no |
| `delegated_permission_classifications` | `delegatedPermissionClassifications` | `list(object({       odata_type = optional(string, "#microsoft.graph.delegatedPermissionClassification")       classification = optional(any)       permissionId = optional(string)       permissionName = optional(string)     }))` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `disabled_by_microsoft_status` | `disabledByMicrosoftStatus` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `endpoints` | `endpoints` | `list(object({       odata_type = optional(string, "#microsoft.graph.endpoint")       capability = optional(string)       deletedDateTime = optional(string)       providerId = optional(string)       providerName = optional(string)       providerResourceId = optional(string)       uri = optional(string)     }))` | no | no |
| `federated_identity_credentials` | `federatedIdentityCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.federatedIdentityCredential")       audiences = optional(list(string))       description = optional(string)       issuer = optional(string)       name = optional(string)       subject = optional(string)     }))` | no | yes |
| `home_realm_discovery_policies` | `homeRealmDiscoveryPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.homeRealmDiscoveryPolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `homepage` | `homepage` | `string` | no | no |
| `info` | `info` | `any` | no | no |
| `is_disabled` | `isDisabled` | `bool` | no | no |
| `key_credentials` | `keyCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       key = optional(string)       keyId = optional(string)       startDateTime = optional(string)       type = optional(string)       usage = optional(string)     }))` | no | yes |
| `login_url` | `loginUrl` | `string` | no | no |
| `logout_url` | `logoutUrl` | `string` | no | no |
| `notes` | `notes` | `string` | no | no |
| `notification_email_addresses` | `notificationEmailAddresses` | `list(string)` | no | no |
| `oauth2_permission_scopes` | `oauth2PermissionScopes` | `list(object({       odata_type = optional(string, "#microsoft.graph.permissionScope")       adminConsentDescription = optional(string)       adminConsentDisplayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       origin = optional(string)       type = optional(string)       userConsentDescription = optional(string)       userConsentDisplayName = optional(string)       value = optional(string)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `owners` | `owners` | `list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     }))` | no | no |
| `password_credentials` | `passwordCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       keyId = optional(string)       startDateTime = optional(string)     }))` | no | yes |
| `preferred_single_sign_on_mode` | `preferredSingleSignOnMode` | `string` | no | no |
| `preferred_token_signing_key_thumbprint` | `preferredTokenSigningKeyThumbprint` | `string` | no | no |
| `remote_desktop_security_configuration` | `remoteDesktopSecurityConfiguration` | `any` | no | no |
| `reply_urls` | `replyUrls` | `list(string)` | no | no |
| `saml_single_sign_on_settings` | `samlSingleSignOnSettings` | `any` | no | no |
| `service_principal_names` | `servicePrincipalNames` | `list(string)` | no | no |
| `service_principal_type` | `servicePrincipalType` | `string` | no | no |
| `synchronization` | `synchronization` | `any` | no | no |
| `tags` | `tags` | `list(string)` | no | no |
| `token_encryption_key_id` | `tokenEncryptionKeyId` | `string` | no | no |
| `token_issuance_policies` | `tokenIssuancePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.tokenIssuancePolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `token_lifetime_policies` | `tokenLifetimePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.tokenLifetimePolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `transitive_member_of` | `transitiveMemberOf` | `list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     }))` | no | no |
| `verified_publisher` | `verifiedPublisher` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Reviewed create-required correction: appId.
- appManagementPolicies[].restrictions: polymorphic schema; accepts an untyped value
- customSecurityAttributes: polymorphic schema; accepts an untyped value
- delegatedPermissionClassifications[].classification: polymorphic schema; accepts an untyped value
- info: polymorphic schema; accepts an untyped value
- remoteDesktopSecurityConfiguration: polymorphic schema; accepts an untyped value
- samlSingleSignOnSettings: polymorphic schema; accepts an untyped value
- synchronization: polymorphic schema; accepts an untyped value
- verifiedPublisher: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
