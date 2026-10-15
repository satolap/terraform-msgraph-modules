# Mock-test helper: binds an extension whose id is unknown at plan time, for an
# access package whose id is unknown too. The same apply creates both in a real
# configuration; terraform_data reports its output as unknown whenever its input
# changes, as those resources do. The provider carries no version constraint here;
# the policy module's applies.
terraform {
  required_providers {
    msgraph = {
      source = "microsoft/msgraph"
    }
  }
}

variable "extension_seed" {
  type    = string
  default = "cccccccc-cccc-cccc-cccc-cccccccccccc"
}

resource "terraform_data" "extension" {
  input = var.extension_seed
}

resource "terraform_data" "access_package" {
  input = "77777777-7777-7777-7777-777777777777"
}

module "policy" {
  source = "../.."

  access_package_id = terraform_data.access_package.output
  display_name      = "Standard request policy"

  custom_extension_stage_settings = [
    { stage = "assignmentRequestGranted", extension_id = terraform_data.extension.output, extension_type = "request_workflow" },
    { stage = "assignmentRequestRemoved", extension_id = terraform_data.extension.output, extension_type = "request_workflow" },
  ]
}

output "id" {
  value = module.policy.id
}
