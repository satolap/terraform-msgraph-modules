terraform {
  required_version = ">= 1.11.0"

  required_providers {
    # 0.5.0 fixes "Provider produced inconsistent final plan" on the sponsors'
    # reference_ids when only some of the sponsor objects change in the same apply.
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.5.0"
    }
  }
}