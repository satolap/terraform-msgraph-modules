# A local-only caller proving the documented ordering requirement without Graph writes.
terraform {
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.6.0, < 0.7.0"
    }
  }
}

variable "writer_revision" {
  type    = string
  default = "initial"
}

resource "terraform_data" "policy_writer" {
  input = var.writer_revision
}

module "verification" {
  source = "../.."

  tier                = "p1"
  baseline_policy_ids = ["00000000-0000-4000-8000-000000000003"]
  exclusions = {
    excludeUsers  = ["00000000-0000-4000-8000-000000000010"]
    excludeGroups = []
  }
  # Known IDs cannot establish this edge; the caller must connect the writer explicitly.
  depends_on = [terraform_data.policy_writer]
}

output "verified" {
  value = module.verification.verified
}
