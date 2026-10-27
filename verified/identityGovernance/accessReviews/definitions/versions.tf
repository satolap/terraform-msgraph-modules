terraform {
  required_version = ">= 1.11.0"

  required_providers {
    # update_method = "PUT" is not the reason for the floor: other verified modules use
    # it from 0.3.0. 0.6.0 is the release whose update, read and import source was
    # reviewed for this module (#258, PL-012 in #265); the upper bound keeps an
    # unreviewed provider release from changing the full-PUT behavior unnoticed.
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.6.0, < 0.7.0"
    }
  }
}
