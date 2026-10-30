# /deviceAppManagement/mdmWindowsInformationProtectionPolicies

Create new navigation property to mdmWindowsInformationProtectionPolicies for deviceAppManagement

[Catalog](../../README.md) Â· [Device and app management](../../README.md#device-and-app-management) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceAppManagement/mdmWindowsInformationProtectionPolicies`, `GET/PATCH/DELETE /deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/device-app-management/mdm-windows-information-protection-policies"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

No select-only inputs are identified by this metadata and contract; classification is incomplete.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.targetedManagedAppPolicyAssignment")       source = optional(string)       sourceId = optional(string)       target = optional(any)     }))` | no | no | in place |
| `azure_rights_management_services_allowed` | `azureRightsManagementServicesAllowed` | `bool` | no | no | in place |
| `created_date_time` | `createdDateTime` | `string` | no | no | in place |
| `data_recovery_certificate` | `dataRecoveryCertificate` | `object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionDataRecoveryCertificate")       certificate = optional(string)       description = optional(string)       expirationDateTime = optional(string)       subjectName = optional(string)     })` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `enforcement_level` | `enforcementLevel` | `string` | no | no | in place |
| `enterprise_domain` | `enterpriseDomain` | `string` | no | no | in place |
| `enterprise_internal_proxy_servers` | `enterpriseInternalProxyServers` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")       displayName = optional(string)       resources = optional(list(string))     }))` | no | no | in place |
| `enterprise_ip_ranges` | `enterpriseIPRanges` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionIPRangeCollection")       displayName = optional(string)       ranges = optional(any)     }))` | no | no | in place |
| `enterprise_ip_ranges_are_authoritative` | `enterpriseIPRangesAreAuthoritative` | `bool` | no | no | in place |
| `enterprise_network_domain_names` | `enterpriseNetworkDomainNames` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")       displayName = optional(string)       resources = optional(list(string))     }))` | no | no | in place |
| `enterprise_protected_domain_names` | `enterpriseProtectedDomainNames` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")       displayName = optional(string)       resources = optional(list(string))     }))` | no | no | in place |
| `enterprise_proxied_domains` | `enterpriseProxiedDomains` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionProxiedDomainCollection")       displayName = optional(string)       proxiedDomains = optional(list(object({       odata_type = optional(string, "#microsoft.graph.proxiedDomain")       ipAddressOrFQDN = optional(string)       proxy = optional(string)     })))     }))` | no | no | in place |
| `enterprise_proxy_servers` | `enterpriseProxyServers` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")       displayName = optional(string)       resources = optional(list(string))     }))` | no | no | in place |
| `enterprise_proxy_servers_are_authoritative` | `enterpriseProxyServersAreAuthoritative` | `bool` | no | no | in place |
| `exempt_app_locker_files` | `exemptAppLockerFiles` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionAppLockerFile")       displayName = optional(string)       file = optional(string)       fileHash = optional(string)       version = optional(string)     }))` | no | no | in place |
| `exempt_apps` | `exemptApps` | `any` | no | no | in place |
| `graph_version` | `version` | `string` | no | no | in place |
| `icons_visible` | `iconsVisible` | `bool` | no | no | in place |
| `indexing_encrypted_stores_or_items_blocked` | `indexingEncryptedStoresOrItemsBlocked` | `bool` | no | no | in place |
| `is_assigned` | `isAssigned` | `bool` | no | no | in place |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no | in place |
| `neutral_domain_resources` | `neutralDomainResources` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")       displayName = optional(string)       resources = optional(list(string))     }))` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `protected_app_locker_files` | `protectedAppLockerFiles` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionAppLockerFile")       displayName = optional(string)       file = optional(string)       fileHash = optional(string)       version = optional(string)     }))` | no | no | in place |
| `protected_apps` | `protectedApps` | `any` | no | no | in place |
| `protection_under_lock_config_required` | `protectionUnderLockConfigRequired` | `bool` | no | no | in place |
| `revoke_on_unenroll_disabled` | `revokeOnUnenrollDisabled` | `bool` | no | no | in place |
| `rights_management_services_template_id` | `rightsManagementServicesTemplateId` | `string` | no | no | in place |
| `role_scope_tag_ids` | `roleScopeTagIds` | `list(string)` | no | no | in place |
| `smb_auto_encrypted_file_extensions` | `smbAutoEncryptedFileExtensions` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsInformationProtectionResourceCollection")       displayName = optional(string)       resources = optional(list(string))     }))` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `id`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /deviceAppManagement/mdmWindowsInformationProtectionPolicies` | DelegatedWork | `DeviceManagementApps.ReadWrite.All` | — |
| `POST /deviceAppManagement/mdmWindowsInformationProtectionPolicies` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /deviceAppManagement/mdmWindowsInformationProtectionPolicies` | Application | `DeviceManagementApps.ReadWrite.All` | — |
| `GET /deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}` | DelegatedWork | `DeviceManagementApps.Read.All` | — |
| `GET /deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}` | DelegatedWork | `DeviceManagementApps.ReadWrite.All` | — |
| `GET /deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}` | Application | `DeviceManagementApps.Read.All` | — |
| `GET /deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}` | Application | `DeviceManagementApps.ReadWrite.All` | — |
| `PATCH /deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}` | DelegatedWork | `DeviceManagementApps.ReadWrite.All` | — |
| `PATCH /deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PATCH /deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}` | Application | `DeviceManagementApps.ReadWrite.All` | — |
| `DELETE /deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}` | DelegatedWork | `DeviceManagementApps.ReadWrite.All` | — |
| `DELETE /deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}` | Application | `DeviceManagementApps.ReadWrite.All` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- assignments[].target: polymorphic schema; accepts an untyped value
- enterpriseIPRanges[].ranges[]: object without documented properties; accepts an untyped value
- exemptApps[]: polymorphic schema; accepts an untyped value
- protectedApps[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
