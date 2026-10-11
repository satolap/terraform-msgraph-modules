# Mock-test helper: reviews by a group whose id is unknown at plan time, as it is when
# the same apply creates the group; terraform_data reports its output as unknown
# whenever its input changes. The provider carries no version constraint here; the
# policy module's applies.
terraform {
  required_providers {
    msgraph = {
      source = "microsoft/msgraph"
    }
  }
}

resource "terraform_data" "reviewers" {
  input = "33333333-3333-3333-3333-333333333333"
}

module "policy" {
  source = "../.."

  access_package_id = "77777777-7777-7777-7777-777777777777"
  display_name      = "Standard request policy"

  review_settings = {
    expiration_behavior = "removeAccess"
    primary_reviewers   = [{ type = "groupMembers", id = terraform_data.reviewers.output }]
    schedule = {
      start_date_time  = "2026-11-01T00:00:00Z"
      duration_in_days = 25
      recurrence       = { type = "absoluteMonthly", interval = 3 }
    }
  }
}

output "id" {
  value = module.policy.id
}
