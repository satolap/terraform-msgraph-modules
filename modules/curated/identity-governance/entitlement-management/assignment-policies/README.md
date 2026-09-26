# identity-governance/entitlement-management/assignment-policies

Manages a Microsoft Entra ID Governance Entitlement Management **access package assignment
policy** (`identityGovernance/entitlementManagement/assignmentPolicies`) via the
`microsoft/msgraph` Terraform provider.

An assignment policy determines who can request or be assigned an access package, whether
approval is required (and by whom, across up to escalating approval stages), what questions
requestors must answer, and when the resulting assignment expires.

## Usage

```hcl
module "engineering_policy" {
  source = "../../modules/curated/identity-governance/entitlement-management/assignment-policies"

  access_package_id    = module.engineering_access.id
  display_name         = "Standard request policy"
  description          = "Employees can request; manager approval required"
  allowed_target_scope = "allMemberUsers"

  expiration = {
    type          = "afterDuration"
    duration_days = 180
  }

  requestor_settings = {
    enable_targets_to_self_add_access = true
  }

  request_approval_settings = {
    is_approval_required_for_add        = true
    is_requestor_justification_required = true

    stages = [
      {
        approval_timeout_in_days = 14
        primary_approvers = [
          { type = "requestorManager" },
        ]
        is_escalation_enabled     = true
        escalation_timeout_in_days = 3
        escalation_approvers = [
          { type = "groupMembers", id = azuread_group.access_reviewers.object_id },
        ]
      },
    ]
  }

  questions = [
    { text = "Why do you need this access?", is_required = true, sequence = 1 },
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| msgraph | >= 0.3.0 |

The configuring identity/application needs the `EntitlementManagement.ReadWrite.All`
Microsoft Graph permission (or the *Access package manager*/*Catalog owner* Entitlement
Management delegated roles).

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | EM-CORE | Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing | direct / per_user | documented |
| `specific_allowed_targets[*].type` contains `"attributeRuleMembers"` | EM-ADVANCED | Automatic assignment through attribute rules, custom extensions and some advanced approval options require Microsoft Entra ID Governance or Microsoft Entra Suite. Microsoft Entra ID P2 alone is not sufficient. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user eligible under the policy that enables the advanced feature | group_based / per_user | documented |
| `requestor_settings.enable_on_behalf_requestors_to_add_access` is `true` | EM-ON-BEHALF | Submitting an access package request on behalf of another user requires both the requestor and the target user to be covered by Microsoft Entra ID Governance or Microsoft Entra Suite. This differs from a manager merely approving a request. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Both the on-behalf requestor and the target user | direct / per_user | documented |
| `requestor_settings.enable_on_behalf_requestors_to_update_access` is `true` | EM-ON-BEHALF | Submitting an access package request on behalf of another user requires both the requestor and the target user to be covered by Microsoft Entra ID Governance or Microsoft Entra Suite. This differs from a manager merely approving a request. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Both the on-behalf requestor and the target user | direct / per_user | documented |
| `requestor_settings.enable_on_behalf_requestors_to_remove_access` is `true` | EM-ON-BEHALF | Submitting an access package request on behalf of another user requires both the requestor and the target user to be covered by Microsoft Entra ID Governance or Microsoft Entra Suite. This differs from a manager merely approving a request. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Both the on-behalf requestor and the target user | direct / per_user | documented |
| `request_approval_settings.approver_information_visibility` is not one of `["default", null]` | EM-ADVANCED | Automatic assignment through attribute rules, custom extensions and some advanced approval options require Microsoft Entra ID Governance or Microsoft Entra Suite. Microsoft Entra ID P2 alone is not sufficient. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user eligible under the policy that enables the advanced feature | group_based / per_user | documented |
| `requestor_settings.on_behalf_requestors[*].type` contains `"targetUserSponsors"` | EM-ADVANCED | Automatic assignment through attribute rules, custom extensions and some advanced approval options require Microsoft Entra ID Governance or Microsoft Entra Suite. Microsoft Entra ID P2 alone is not sufficient. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user eligible under the policy that enables the advanced feature | group_based / per_user | documented |
| `allowed_target_scope` is one of `["specificDirectoryServicePrincipals", "allDirectoryServicePrincipals", "allDirectoryAgentIdentities"]` | AGENT-IDENTITIES | Policies that target service principals or agent identities depend on Microsoft Agent 365 requirements that have not been reviewed for these modules. Treat the requirement as unknown until reviewed together with the API version and end-to-end behavior. No additional license specified. | Unknown | group_based / per_tenant | unknown |

Notes:

- An accepted enum value is not evidence of entitlement or lifecycle support. Human-user policies with standard approval stages, questions and expiration are the reviewed core profile.
- When `specific_allowed_targets[*].type` contains `"attributeRuleMembers"`: Attribute-rule targets describe automatic assignment; inspect the emitted body and Graph contract before treating it as a supported workflow.
- When `request_approval_settings.approver_information_visibility` is not one of `["default", null]`: Nondefault approver information visibility is an advanced approval option; verify the exact feature mapping before enabling it in a licensed test.
- When `requestor_settings.on_behalf_requestors[*].type` contains `"targetUserSponsors"`: Sponsor-based subject sets are a feature-review trigger.

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license), [Request on behalf of other users](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-request-behalf), [Microsoft Entra ID Governance licensing fundamentals](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#types-of-licenses).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| access_package_id | ID of the access package this policy applies to | `string` | n/a | yes |
| display_name | Display name of the policy (1-90 characters) | `string` | n/a | yes |
| description | Description of the policy | `string` | `null` | no |
| allowed_target_scope | Who can be assigned via this policy (see `accessPackageAssignmentPolicy.allowedTargetScope` values) | `string` | `"notSpecified"` | no |
| specific_allowed_targets | Principals allowed when allowed_target_scope is a "specific*" value | `list(object)` | `[]` | no |
| expiration | `{ type, duration_days, end_date_time }` — expiration pattern for assignments | `object` | `{ type = "noExpiration" }` | no |
| requestor_settings | Self-service/on-behalf-of request toggles and on-behalf-of requestors | `object` | `{}` | no |
| request_approval_settings | Approval requirement flags and escalating approval stages | `object` | `{}` | no |
| questions | Text-input questions posed to the requestor | `list(object)` | `[]` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

Approver/requestor/target objects share the shape `{ type, id, description, membership_rule }`,
where `type` is one of Microsoft Graph's `subjectSet` subtypes (`singleUser`, `groupMembers`,
`requestorManager`, `internalSponsors`, `externalSponsors`, `targetUserSponsors`, plus
`connectedOrganizationMembers` and `attributeRuleMembers` for `specific_allowed_targets`).
`id` maps to the correct underlying Graph property (`userId`, `groupId`, or
`connectedOrganizationId`) automatically based on `type`.

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the assignment policy |
| display_name | The display name of the assignment policy |
| access_package_id | The ID of the parent access package |
