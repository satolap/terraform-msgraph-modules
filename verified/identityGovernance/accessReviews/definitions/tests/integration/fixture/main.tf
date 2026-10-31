terraform {
  required_version = ">= 1.11.0"
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.6.0, < 0.7.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.0, < 1.0.0"
    }
  }
}
variable "enabled" {
  type    = bool
  default = true
}
variable "removed_id" {
  type    = string
  default = null
}
variable "description" {
  type    = string
  default = "Created by terraform test; safe to delete"
}
resource "terraform_data" "suffix" {
  input = substr(uuid(), 0, 8)
  lifecycle {
    ignore_changes = [input]
  }
}
variable "verified_domain" {
  type = string
}
resource "random_password" "member_one" {
  length      = 24
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}
module "member_one" {
  source            = "../../../../../../users"
  userPrincipalName = "tftest-member_one-${terraform_data.suffix.output}@${var.verified_domain}"
  displayName       = "tftest-member_one-${terraform_data.suffix.output}"
  mailNickname      = "tftest-member_one-${terraform_data.suffix.output}"
  password          = random_password.member_one.result
  accountEnabled    = false
}
resource "random_password" "member_two" {
  length      = 24
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}
module "member_two" {
  source            = "../../../../../../users"
  userPrincipalName = "tftest-member_two-${terraform_data.suffix.output}@${var.verified_domain}"
  displayName       = "tftest-member_two-${terraform_data.suffix.output}"
  mailNickname      = "tftest-member_two-${terraform_data.suffix.output}"
  password          = random_password.member_two.result
  accountEnabled    = false
}
resource "random_password" "reviewer" {
  length      = 24
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}
module "reviewer" {
  source            = "../../../../../../users"
  userPrincipalName = "tftest-reviewer-${terraform_data.suffix.output}@${var.verified_domain}"
  displayName       = "tftest-reviewer-${terraform_data.suffix.output}"
  mailNickname      = "tftest-reviewer-${terraform_data.suffix.output}"
  password          = random_password.reviewer.result
  accountEnabled    = false
}
variable "review_start_date" {
  type        = string
  description = "Explicit future YYYY-MM-DD start date; no date is derived by the suite."
  validation {
    condition     = can(formatdate("YYYY-MM-DD", "${var.review_start_date}T00:00:00Z"))
    error_message = "review_start_date must be a calendar date."
  }
}
module "group" {
  source          = "../../../../../../groups"
  displayName     = "tftest-review-${terraform_data.suffix.output}"
  mailNickname    = "tftest-review-${terraform_data.suffix.output}"
  securityEnabled = true
  member_ids      = [module.member_one.id, module.member_two.id]
}
module "definition" {
  source                    = "../../.."
  count                     = var.enabled ? 1 : 0
  displayName               = "tftest-review-${terraform_data.suffix.output}"
  descriptionForAdmins      = var.description
  descriptionForReviewers   = "Disposable offline-subject review; do not act"
  group_id                  = module.group.id
  membership_scope          = "transitive"
  reviewer_user_ids         = [module.reviewer.id]
  depends_on                = [terraform_data.future_date]
  start_date                = var.review_start_date
  recurrence                = { type = "weekly", interval = 1, numberOfOccurrences = 1 }
  instance_duration_in_days = 1
}
resource "terraform_data" "future_date" {
  input = var.review_start_date
  lifecycle {
    precondition {
      condition     = timecmp("${var.review_start_date}T00:00:00Z", timeadd(plantimestamp(), "24h")) > 0
      error_message = "Choose an explicit review start date more than 24 hours in the future."
    }
  }
}
output "expected" {
  value = {
    group_query    = "/groups/${module.group.id}/transitiveMembers"
    reviewer_query = "/users/${module.reviewer.id}"
    members        = [module.member_one.id, module.member_two.id]
  }
}
data "msgraph_resource" "members" {
  url                    = "groups/${module.group.id}/members"
  response_export_values = { collection = "@" }
  depends_on             = [module.definition]
}
output "members_unchanged" {
  value = alltrue([
    try(data.msgraph_resource.members.output.collection["@odata.nextLink"], null) == null,
    toset([for item in data.msgraph_resource.members.output.collection.value : item.id]) == toset([module.member_one.id, module.member_two.id]),
  ])
}
# Independent GET, separate from the module's create/refresh response.
data "msgraph_resource" "item" {
  count                  = var.enabled ? 1 : 0
  url                    = "identityGovernance/accessReviews/definitions/${module.definition[0].id}"
  response_export_values = { item = "@" }
  retry                  = { error_message_regex = ["(?i)Request_ResourceNotFound|NotFound|404"] }
  timeouts { read = "2m" }
  depends_on = [module.definition]
}
data "msgraph_resource" "remaining" {
  count = var.enabled ? 0 : 1
  url   = "identityGovernance/accessReviews/definitions"
  query_parameters = {
    "$filter" = ["displayName eq 'tftest-review-${terraform_data.suffix.output}'"]
  }
  response_export_values = { collection = "@" }
  depends_on             = [module.definition]
}
output "id" {
  value = var.enabled ? module.definition[0].id : null
}
output "item" {
  value = var.enabled ? data.msgraph_resource.item[0].output.item : null
}
output "absent" {
  value = var.enabled ? false : var.removed_id == null ? false : alltrue([
    try(data.msgraph_resource.remaining[0].output.collection["@odata.nextLink"], null) == null,
    !contains([for item in data.msgraph_resource.remaining[0].output.collection.value : item.id], var.removed_id),
  ])
}
