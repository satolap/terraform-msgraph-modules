# /applications

Create application

[Catalog](../../README.md) · [Applications](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/application?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /applications`, `GET/PATCH/DELETE /applications/{application-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./applications/applications"
  display_name = "example"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `display_name` | `displayName` | `string` | yes | no |
| `add_ins` | `addIns` | `list(object({       odata_type = optional(string, "#microsoft.graph.addIn")       id = optional(string)       properties = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     })))       type = optional(string)     }))` | no | no |
| `api` | `api` | `any` | no | no |
| `app_management_policies` | `appManagementPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.appManagementPolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isEnabled = optional(bool)       restrictions = optional(any)     }))` | no | no |
| `app_roles` | `appRoles` | `list(object({       odata_type = optional(string, "#microsoft.graph.appRole")       allowedMemberTypes = optional(list(string))       description = optional(string)       displayName = optional(string)       id = optional(string)       isEnabled = optional(bool)       value = optional(string)     }))` | no | no |
| `authentication_behaviors` | `authenticationBehaviors` | `any` | no | no |
| `certification` | `certification` | `any` | no | no |
| `default_redirect_uri` | `defaultRedirectUri` | `string` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `disabled_by_microsoft_status` | `disabledByMicrosoftStatus` | `string` | no | no |
| `federated_identity_credentials` | `federatedIdentityCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.federatedIdentityCredential")       audiences = optional(list(string))       description = optional(string)       issuer = optional(string)       name = optional(string)       subject = optional(string)     }))` | no | yes |
| `group_membership_claims` | `groupMembershipClaims` | `string` | no | no |
| `home_realm_discovery_policies` | `homeRealmDiscoveryPolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.homeRealmDiscoveryPolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `identifier_uris` | `identifierUris` | `list(string)` | no | no |
| `info` | `info` | `any` | no | no |
| `is_device_only_auth_supported` | `isDeviceOnlyAuthSupported` | `bool` | no | no |
| `is_disabled` | `isDisabled` | `bool` | no | no |
| `is_fallback_public_client` | `isFallbackPublicClient` | `bool` | no | no |
| `key_credentials` | `keyCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       key = optional(string)       keyId = optional(string)       startDateTime = optional(string)       type = optional(string)       usage = optional(string)     }))` | no | yes |
| `logo` | `logo` | `string` | no | no |
| `manager_applications` | `managerApplications` | `list(string)` | no | no |
| `native_authentication_apis_enabled` | `nativeAuthenticationApisEnabled` | `any` | no | no |
| `notes` | `notes` | `string` | no | no |
| `oauth2_require_post_response` | `oauth2RequirePostResponse` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `optional_claims` | `optionalClaims` | `any` | no | no |
| `owners` | `owners` | `list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     }))` | no | no |
| `parental_control_settings` | `parentalControlSettings` | `any` | no | no |
| `password_credentials` | `passwordCredentials` | `list(object({       odata_type = optional(string, "#microsoft.graph.passwordCredential")       customKeyIdentifier = optional(string)       displayName = optional(string)       endDateTime = optional(string)       keyId = optional(string)       startDateTime = optional(string)     }))` | no | yes |
| `public_client` | `publicClient` | `any` | no | no |
| `request_signature_verification` | `requestSignatureVerification` | `any` | no | no |
| `required_resource_access` | `requiredResourceAccess` | `list(object({       odata_type = optional(string, "#microsoft.graph.requiredResourceAccess")       resourceAccess = optional(list(object({       odata_type = optional(string, "#microsoft.graph.resourceAccess")       id = optional(string)       type = optional(string)     })))       resourceAppId = optional(string)     }))` | no | no |
| `saml_metadata_url` | `samlMetadataUrl` | `string` | no | no |
| `service_management_reference` | `serviceManagementReference` | `string` | no | no |
| `service_principal_lock_configuration` | `servicePrincipalLockConfiguration` | `any` | no | no |
| `sign_in_audience` | `signInAudience` | `string` | no | no |
| `spa` | `spa` | `any` | no | no |
| `synchronization` | `synchronization` | `any` | no | no |
| `tags` | `tags` | `list(string)` | no | no |
| `token_encryption_key_id` | `tokenEncryptionKeyId` | `string` | no | no |
| `token_issuance_policies` | `tokenIssuancePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.tokenIssuancePolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `token_lifetime_policies` | `tokenLifetimePolicies` | `list(object({       odata_type = optional(string, "#microsoft.graph.tokenLifetimePolicy")       appliesTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     })))       definition = optional(list(string))       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isOrganizationDefault = optional(bool)     }))` | no | no |
| `verified_publisher` | `verifiedPublisher` | `any` | no | no |
| `web` | `web` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Reviewed create-required correction: displayName.
- api: polymorphic schema; accepts an untyped value
- appManagementPolicies[].restrictions: polymorphic schema; accepts an untyped value
- authenticationBehaviors: polymorphic schema; accepts an untyped value
- certification: polymorphic schema; accepts an untyped value
- info: polymorphic schema; accepts an untyped value
- nativeAuthenticationApisEnabled: polymorphic schema; accepts an untyped value
- optionalClaims: polymorphic schema; accepts an untyped value
- parentalControlSettings: polymorphic schema; accepts an untyped value
- publicClient: polymorphic schema; accepts an untyped value
- requestSignatureVerification: polymorphic schema; accepts an untyped value
- servicePrincipalLockConfiguration: polymorphic schema; accepts an untyped value
- spa: polymorphic schema; accepts an untyped value
- synchronization: polymorphic schema; accepts an untyped value
- verifiedPublisher: polymorphic schema; accepts an untyped value
- web: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
