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
  source = "../../modules/identity-governance/entitlement-management/assignment-policies"

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
