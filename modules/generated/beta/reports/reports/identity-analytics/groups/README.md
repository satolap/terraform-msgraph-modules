# /reports/identityAnalytics/groups

Create new navigation property to groups for reports

[Catalog](../../../../README.md) · [Reports](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/groupanalytics?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /reports/identityAnalytics/groups`, `GET/PATCH/DELETE /reports/identityAnalytics/groups/{groupAnalytics-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./reports/reports/identity-analytics/groups"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `assigned_role_count` | `assignedRoleCount` | `number` | no | no |
| `calculated_date_time` | `calculatedDateTime` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `direct_group_member_count` | `directGroupMemberCount` | `number` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `dynamic_membership_type` | `dynamicMembershipType` | `string` | no | no |
| `group_expiration_date_time` | `groupExpirationDateTime` | `string` | no | no |
| `group_type` | `groupType` | `string` | no | no |
| `guest_owner_count` | `guestOwnerCount` | `number` | no | no |
| `guest_transitive_user_count` | `guestTransitiveUserCount` | `number` | no | no |
| `is_cloud_distribution_list_group` | `isCloudDistributionListGroup` | `bool` | no | no |
| `is_cloud_m365_group` | `isCloudM365Group` | `bool` | no | no |
| `is_cloud_mail_enabled_security_group` | `isCloudMailEnabledSecurityGroup` | `bool` | no | no |
| `is_cloud_security_group` | `isCloudSecurityGroup` | `bool` | no | no |
| `is_dynamic_group` | `isDynamicGroup` | `bool` | no | no |
| `is_on_premise_distribution_list_group` | `isOnPremiseDistributionListGroup` | `bool` | no | no |
| `is_on_premise_mail_enabled_security_group` | `isOnPremiseMailEnabledSecurityGroup` | `bool` | no | no |
| `is_on_premise_security_group` | `isOnPremiseSecurityGroup` | `bool` | no | no |
| `is_valid_group` | `isValidGroup` | `bool` | no | no |
| `last_restoration_date_time` | `lastRestorationDateTime` | `string` | no | no |
| `member_owner_count` | `memberOwnerCount` | `number` | no | no |
| `member_transitive_user_count` | `memberTransitiveUserCount` | `number` | no | no |
| `membership_rule_contains_count` | `membershipRuleContainsCount` | `number` | no | no |
| `membership_rule_expression_count` | `membershipRuleExpressionCount` | `number` | no | no |
| `membership_rule_match_count` | `membershipRuleMatchCount` | `number` | no | no |
| `membership_rule_member_of_count` | `membershipRuleMemberOfCount` | `number` | no | no |
| `membership_rule_processing_state` | `membershipRuleProcessingState` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `preferred_data_location` | `preferredDataLocation` | `string` | no | no |
| `sensitivity_label_count` | `sensitivityLabelCount` | `number` | no | no |
| `service_principal_owner_count` | `servicePrincipalOwnerCount` | `number` | no | no |
| `soft_deletion_date_time` | `softDeletionDateTime` | `string` | no | no |
| `tenant_id` | `tenantId` | `string` | no | no |
| `transitive_service_principal_count` | `transitiveServicePrincipalCount` | `number` | no | no |
| `transitive_user_count` | `transitiveUserCount` | `number` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
