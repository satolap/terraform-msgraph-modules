# Independent bounded GET verification; a new run_label schedules a fresh read.
# Poll (bounded by the read timeout) until the response shows the expected
# trust flag, name and range count, and stop at once when it already does
# (GB-conditional-access-505: stale reads can carry the old name, trust or ranges).
terraform {
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.5.0"
    }
  }
}

variable "named_location_id" {
  type = string
}

variable "run_label" {
  type = string
}

variable "expected_display_name" {
  type = string
}

variable "expected_is_trusted" {
  type = bool
}

variable "expected_ip_ranges" {
  type = list(string)
}

# Optional pre-update values: a response that still shows one is stale.
variable "previous_display_name" {
  type    = string
  default = null
}

variable "previous_ip_ranges" {
  type    = list(string)
  default = []
}

locals {
  expected_count = length(var.expected_ip_ranges)
  stale_cidrs    = [for c in var.previous_ip_ranges : c if !contains(var.expected_ip_ranges, c)]
  # RE2 has no negative lookahead, so stale responses are matched by what they
  # show: the opposite trust flag, the previous name, a previous-only range, or
  # an ipRanges array with fewer entries than expected (range objects are flat).
  stale_patterns = concat(
    [var.expected_is_trusted ? "\"isTrusted\"\\s*:\\s*false\\b" : "\"isTrusted\"\\s*:\\s*true\\b"],
    var.previous_display_name == null ? [] : ["\"displayName\"\\s*:\\s*\"${replace(var.previous_display_name, ".", "\\.")}\""],
    [for c in local.stale_cidrs : "\"cidrAddress\"\\s*:\\s*\"${replace(c, ".", "\\.")}\""],
    local.expected_count < 1 ? [] : ["\"ipRanges\"\\s*:\\s*\\[(\\s*\\{[^{}]*\\}\\s*,?){0,${local.expected_count - 1}}\\s*\\]"],
  )
}

resource "terraform_data" "read_generation" {
  input = { named_location_id = var.named_location_id, run_label = var.run_label }
}

data "msgraph_resource" "named_location" {
  url         = "identity/conditionalAccess/namedLocations/${var.named_location_id}"
  api_version = "v1.0"

  response_export_values = {
    all = "@"
  }

  retry = { error_message_regex = ["\"isTrusted\"\\s*:\\s*true\\b"] }
  timeouts { read = "2m" }
  depends_on = [terraform_data.read_generation]

  lifecycle {
    postcondition {
      condition = try(alltrue([
        self.output.all.id == var.named_location_id,
        self.output.all.isTrusted == var.expected_is_trusted,
        self.output.all.displayName == var.expected_display_name,
        sort([for r in self.output.all.ipRanges : r.cidrAddress]) == sort(var.expected_ip_ranges),
      ]), false)
      error_message = "Independent GET did not converge to the expected name, trust flag and ranges within two minutes; preserve ownership evidence for #208 recovery."
    }
  }
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
