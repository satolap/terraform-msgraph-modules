terraform {
  required_version = ">= 1.11.0"

  required_providers {
    # 0.5.0 is the floor of the other verified modules that read back a partial
    # response: ignore_missing_property keeps a configured key that a read does
    # not return.
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.5.0"
    }
  }
}
