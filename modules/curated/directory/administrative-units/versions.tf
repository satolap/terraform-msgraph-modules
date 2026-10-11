terraform {
  required_version = ">= 1.5.0"

  required_providers {
    # 0.5.0 fixes "Provider produced inconsistent final plan" on reference_ids when
    # only some of the member objects change in the same apply.
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.5.0"
    }
  }
}