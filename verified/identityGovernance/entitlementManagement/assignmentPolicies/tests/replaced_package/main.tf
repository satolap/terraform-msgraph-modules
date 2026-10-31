# Mock-test helper: an access package that is replaced, new one first, as the
# access-packages module does when its catalog changes, and a group that the
# policy names as a target. A new package_seed replaces the package, so its id
# is unknown while the plan replaces the policy. The provider carries no
# version constraint here; the policy module's applies.
terraform {
  required_providers {
    msgraph = {
      source = "microsoft/msgraph"
    }
  }
}

variable "package_seed" {
  type    = string
  default = "first"
}

resource "terraform_data" "access_package" {
  triggers_replace = var.package_seed
  input            = var.package_seed

  lifecycle {
    create_before_destroy = true
  }
}

resource "terraform_data" "group" {
  input = "33333333-3333-3333-3333-333333333333"
}

module "policy" {
  source = "../.."

  access_package_id  = terraform_data.access_package.id
  displayName        = "Standard request policy"
  allowedTargetScope = "specificDirectoryUsers"

  specific_allowed_targets = [
    { type = "groupMembers", id = terraform_data.group.output },
  ]
}

output "access_package_id" {
  value = terraform_data.access_package.id
}

output "policy_id" {
  value = module.policy.id
}

output "policy_access_package_id" {
  value = module.policy.access_package_id
}
