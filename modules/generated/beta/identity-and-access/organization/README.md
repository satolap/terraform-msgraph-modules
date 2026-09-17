# /organization

Add new entity to organization

[Catalog](../../README.md) · [Identity and access](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/organization?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /organization`, `GET/PATCH/DELETE /organization/{organization-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/organization"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `assigned_plans` | `assignedPlans` | `list(object({       odata_type = optional(string, "#microsoft.graph.assignedPlan")       assignedDateTime = optional(string)       capabilityStatus = optional(string)       service = optional(string)       servicePlanId = optional(string)     }))` | no | no |
| `branding` | `branding` | `any` | no | no |
| `business_phones` | `businessPhones` | `list(string)` | no | no |
| `certificate_based_auth_configuration` | `certificateBasedAuthConfiguration` | `list(object({       odata_type = optional(string, "#microsoft.graph.certificateBasedAuthConfiguration")       certificateAuthorities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.certificateAuthority")       certificate = optional(string)       certificateRevocationListUrl = optional(string)       deltaCertificateRevocationListUrl = optional(string)       isRootAuthority = optional(bool)     })))     }))` | no | no |
| `certificate_connector_setting` | `certificateConnectorSetting` | `any` | no | no |
| `city` | `city` | `string` | no | no |
| `country` | `country` | `string` | no | no |
| `country_letter_code` | `countryLetterCode` | `string` | no | no |
| `default_usage_location` | `defaultUsageLocation` | `string` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `directory_size_quota` | `directorySizeQuota` | `any` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `extensions` | `extensions` | `list(object({       odata_type = optional(string, "#microsoft.graph.extension")     }))` | no | no |
| `marketing_notification_emails` | `marketingNotificationEmails` | `list(string)` | no | no |
| `mobile_device_management_authority` | `mobileDeviceManagementAuthority` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `on_premises_last_password_sync_date_time` | `onPremisesLastPasswordSyncDateTime` | `string` | no | yes |
| `on_premises_last_sync_date_time` | `onPremisesLastSyncDateTime` | `string` | no | no |
| `on_premises_sync_enabled` | `onPremisesSyncEnabled` | `bool` | no | no |
| `partner_information` | `partnerInformation` | `any` | no | no |
| `partner_tenant_type` | `partnerTenantType` | `any` | no | no |
| `postal_code` | `postalCode` | `string` | no | no |
| `preferred_language` | `preferredLanguage` | `string` | no | no |
| `privacy_profile` | `privacyProfile` | `any` | no | no |
| `provisioned_plans` | `provisionedPlans` | `list(object({       odata_type = optional(string, "#microsoft.graph.provisionedPlan")       capabilityStatus = optional(string)       provisioningStatus = optional(string)       service = optional(string)     }))` | no | no |
| `resource_quotas` | `resourceQuotas` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceQuota")       maxPercentage = optional(number)       resourceType = optional(string)       total = optional(number)     }))` | no | no |
| `security_compliance_notification_mails` | `securityComplianceNotificationMails` | `list(string)` | no | no |
| `security_compliance_notification_phones` | `securityComplianceNotificationPhones` | `list(string)` | no | no |
| `settings` | `settings` | `any` | no | no |
| `state` | `state` | `string` | no | no |
| `street` | `street` | `string` | no | no |
| `technical_notification_mails` | `technicalNotificationMails` | `list(string)` | no | no |
| `tenant_type` | `tenantType` | `string` | no | no |
| `verified_domains` | `verifiedDomains` | `list(object({       odata_type = optional(string, "#microsoft.graph.verifiedDomain")       capabilities = optional(string)       isDefault = optional(bool)       isInitial = optional(bool)       name = optional(string)       type = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- branding: polymorphic schema; accepts an untyped value
- certificateConnectorSetting: polymorphic schema; accepts an untyped value
- directorySizeQuota: polymorphic schema; accepts an untyped value
- partnerInformation: polymorphic schema; accepts an untyped value
- partnerTenantType: polymorphic schema; accepts an untyped value
- privacyProfile: polymorphic schema; accepts an untyped value
- settings: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
