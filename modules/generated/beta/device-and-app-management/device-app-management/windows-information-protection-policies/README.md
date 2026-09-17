# /deviceAppManagement/windowsInformationProtectionPolicies

Create new navigation property to windowsInformationProtectionPolicies for deviceAppManagement

[Catalog](../../../README.md) · [Device and app management](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-windowsinformationprotectionpolicy?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceAppManagement/windowsInformationProtectionPolicies`, `GET/PATCH/DELETE /deviceAppManagement/windowsInformationProtectionPolicies/{windowsInformationProtectionPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-app-management/windows-information-protection-policies"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.targetedManagedAppPolicyAssignment")       source = optional(string)       sourceId = optional(string)       target = optional(any)     }))` | no | no |
| `azure_rights_management_services_allowed` | `azureRightsManagementServicesAllowed` | `bool` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `data_recovery_certificate` | `dataRecoveryCertificate` | `any` | no | no |
| `days_without_contact_before_unenroll` | `daysWithoutContactBeforeUnenroll` | `number` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `enforcement_level` | `enforcementLevel` | `string` | no | no |
| `enterprise_domain` | `enterpriseDomain` | `string` | no | no |
| `enterprise_internal_proxy_servers` | `enterpriseInternalProxyServers` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")       displayName = optional(string)       resources = optional(list(string))     }))` | no | no |
| `enterprise_ip_ranges` | `enterpriseIPRanges` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionIPRangeCollection")       displayName = optional(string)       ranges = optional(list(object({       odata_type = optional(string, "#microsoft.graph.ipRange")     })))     }))` | no | no |
| `enterprise_ip_ranges_are_authoritative` | `enterpriseIPRangesAreAuthoritative` | `bool` | no | no |
| `enterprise_network_domain_names` | `enterpriseNetworkDomainNames` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")       displayName = optional(string)       resources = optional(list(string))     }))` | no | no |
| `enterprise_protected_domain_names` | `enterpriseProtectedDomainNames` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")       displayName = optional(string)       resources = optional(list(string))     }))` | no | no |
| `enterprise_proxied_domains` | `enterpriseProxiedDomains` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionProxiedDomainCollection")       displayName = optional(string)       proxiedDomains = optional(list(object({       odata_type = optional(string, "#microsoft.graph.proxiedDomain")       ipAddressOrFQDN = optional(string)       proxy = optional(string)     })))     }))` | no | no |
| `enterprise_proxy_servers` | `enterpriseProxyServers` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")       displayName = optional(string)       resources = optional(list(string))     }))` | no | no |
| `enterprise_proxy_servers_are_authoritative` | `enterpriseProxyServersAreAuthoritative` | `bool` | no | no |
| `exempt_app_locker_files` | `exemptAppLockerFiles` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionAppLockerFile")       displayName = optional(string)       file = optional(string)       fileHash = optional(string)       version = optional(string)     }))` | no | no |
| `exempt_apps` | `exemptApps` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionApp")       denied = optional(bool)       description = optional(string)       displayName = optional(string)       productName = optional(string)       publisherName = optional(string)     }))` | no | no |
| `graph_version` | `version` | `string` | no | no |
| `icons_visible` | `iconsVisible` | `bool` | no | no |
| `indexing_encrypted_stores_or_items_blocked` | `indexingEncryptedStoresOrItemsBlocked` | `bool` | no | no |
| `is_assigned` | `isAssigned` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `mdm_enrollment_url` | `mdmEnrollmentUrl` | `string` | no | no |
| `minutes_of_inactivity_before_device_lock` | `minutesOfInactivityBeforeDeviceLock` | `number` | no | no |
| `neutral_domain_resources` | `neutralDomainResources` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")       displayName = optional(string)       resources = optional(list(string))     }))` | no | no |
| `number_of_past_pins_remembered` | `numberOfPastPinsRemembered` | `number` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `password_maximum_attempt_count` | `passwordMaximumAttemptCount` | `number` | no | yes |
| `pin_expiration_days` | `pinExpirationDays` | `number` | no | no |
| `pin_lowercase_letters` | `pinLowercaseLetters` | `string` | no | no |
| `pin_minimum_length` | `pinMinimumLength` | `number` | no | no |
| `pin_special_characters` | `pinSpecialCharacters` | `string` | no | no |
| `pin_uppercase_letters` | `pinUppercaseLetters` | `string` | no | no |
| `protected_app_locker_files` | `protectedAppLockerFiles` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionAppLockerFile")       displayName = optional(string)       file = optional(string)       fileHash = optional(string)       version = optional(string)     }))` | no | no |
| `protected_apps` | `protectedApps` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionApp")       denied = optional(bool)       description = optional(string)       displayName = optional(string)       productName = optional(string)       publisherName = optional(string)     }))` | no | no |
| `protection_under_lock_config_required` | `protectionUnderLockConfigRequired` | `bool` | no | no |
| `revoke_on_mdm_handoff_disabled` | `revokeOnMdmHandoffDisabled` | `bool` | no | no |
| `revoke_on_unenroll_disabled` | `revokeOnUnenrollDisabled` | `bool` | no | no |
| `rights_management_services_template_id` | `rightsManagementServicesTemplateId` | `string` | no | no |
| `role_scope_tag_ids` | `roleScopeTagIds` | `list(string)` | no | no |
| `smb_auto_encrypted_file_extensions` | `smbAutoEncryptedFileExtensions` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")       displayName = optional(string)       resources = optional(list(string))     }))` | no | no |
| `windows_hello_for_business_blocked` | `windowsHelloForBusinessBlocked` | `bool` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- assignments[].target: polymorphic schema; accepts an untyped value
- dataRecoveryCertificate: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
