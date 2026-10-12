# Mock-test helper: passes an authentication strength id to the policy module
# that is unknown at plan time. terraform_data reports its output as unknown
# whenever its input changes, as a strength resource does when the same apply
# creates or replaces it. A strength_id set here is known at plan time. The
# provider carries no version constraint here; the policy module's applies.
terraform {
  required_providers {
    msgraph = {
      source = "microsoft/msgraph"
    }
  }
}

variable "strength_seed" {
  type    = string
  default = "00000000-0000-0000-0000-000000000002"
}

variable "strength_id" {
  type    = string
  default = null
}

resource "terraform_data" "strength" {
  input = var.strength_seed
}

module "policy" {
  source = "../.."

  display_name         = "Require a strength for pilot"
  break_glass_user_ids = ["11111111-1111-1111-1111-111111111111"]
  users                = { include_groups = ["22222222-2222-2222-2222-222222222222"] }
  applications         = { include_applications = ["All"] }
  grant_controls       = { authentication_strength_id = var.strength_id != null ? var.strength_id : terraform_data.strength.output }
}

output "id" {
  value = module.policy.id
}
