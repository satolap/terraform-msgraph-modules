# Mock-test helper: puts three groups that the same apply creates into one
# administrative unit. terraform_data stands in for the groups, because the mock
# provider would give every group the same id; its output is unknown at plan
# time, as a new group's id is. The list itself is known, so the unit's member
# resource can be counted at plan time. The provider carries no version
# constraint here; the unit module's applies.
terraform {
  required_providers {
    msgraph = {
      source = "microsoft/msgraph"
    }
  }
}

resource "terraform_data" "group" {
  for_each = {
    owners    = "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"
    approvers = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
    members   = "cccccccc-cccc-4ccc-8ccc-cccccccccccc"
  }

  input = each.value
}

module "unit" {
  source = "../.."

  display_name = "Fabrikam partners"
  member_ids   = [for key in ["owners", "approvers", "members"] : terraform_data.group[key].output]
}

output "id" {
  value = module.unit.id
}

output "member_ids" {
  value = module.unit.member_ids
}
