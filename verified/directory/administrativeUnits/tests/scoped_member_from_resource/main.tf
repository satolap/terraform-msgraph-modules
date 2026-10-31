# Mock-test helper: assigns a role over a unit to a user that the same apply
# creates. terraform_data stands in for the user; its output is unknown at plan
# time, as a new user's id is. The map keys are known, so the scoped role
# member resources can be planned. The provider carries no version constraint
# here; the unit module's applies.
terraform {
  required_providers {
    msgraph = {
      source = "microsoft/msgraph"
    }
  }
}

resource "terraform_data" "user" {
  input = "BBBBBBBB-BBBB-4BBB-8BBB-BBBBBBBBBBBB"
}

module "unit" {
  source = "../.."

  displayName = "Fabrikam partners"

  scoped_role_members = {
    groups_administrator = {
      roleId    = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      member_id = terraform_data.user.output
    }
  }
}

output "scoped_role_member_ids" {
  value = module.unit.scoped_role_member_ids
}
