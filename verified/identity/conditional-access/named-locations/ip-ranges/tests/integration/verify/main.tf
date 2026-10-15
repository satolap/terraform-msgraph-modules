# Integration-test helper: waits, then reads the named location back with a
# fresh GET and returns it in a normalised form (ranges sorted by address).
# A new run_label replaces the wait, so every verify run reads after its own
# delay instead of reusing an earlier read.
terraform {
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.5.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.0"
    }
  }
}

variable "named_location_id" {
  type = string
}

variable "run_label" {
  type = string
}

variable "delay_seconds" {
  type    = number
  default = 30
}

resource "time_sleep" "settle" {
  create_duration = "${var.delay_seconds}s"

  triggers = {
    named_location_id = var.named_location_id
    run_label         = var.run_label
  }
}

data "msgraph_resource" "named_location" {
  url         = "identity/conditionalAccess/namedLocations/${var.named_location_id}"
  api_version = "v1.0"

  response_export_values = {
    all = "@"
  }

  depends_on = [time_sleep.settle]
}

locals {
  got    = data.msgraph_resource.named_location.output.all
  ranges = try([for r in local.got.ipRanges : r], [])
}

output "configuration" {
  value = {
    odata_type   = try(local.got["@odata.type"], null)
    display_name = try(local.got.displayName, null)
    is_trusted   = try(local.got.isTrusted, null)
    ip_ranges = [
      for address in sort([for r in local.ranges : r.cidrAddress]) : one([
        for r in local.ranges : { odata_type = try(r["@odata.type"], null), cidr_address = r.cidrAddress } if r.cidrAddress == address
      ])
    ]
  }
}
