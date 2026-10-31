locals {
  # The derived @odata.type is required on create and on every update, and each
  # range carries its own type. Ranges are sorted so that caller order never
  # causes an update; the provider compares arrays by position.
  body = {
    "@odata.type" = "#microsoft.graph.ipNamedLocation"
    displayName   = var.displayName
    isTrusted     = var.isTrusted
    ipRanges = [for r in sort(var.ip_ranges) : {
      "@odata.type" = strcontains(r, ":") ? "#microsoft.graph.iPv6CidrRange" : "#microsoft.graph.iPv4CidrRange"
      cidrAddress   = r
    }]
  }
}

resource "msgraph_resource" "named_location" {
  url                     = "identity/conditionalAccess/namedLocations"
  api_version             = var.api_version
  body                    = local.body
  ignore_missing_property = false

  response_export_values = {
    display_name = "displayName"
    is_trusted   = "isTrusted"
    ip_ranges    = "ipRanges[].cidrAddress"
  }

  timeouts {
    create = var.timeouts.create
    read   = var.timeouts.read
    update = var.timeouts.update
    delete = var.timeouts.delete
  }

  lifecycle {
    # Keep the final trust write minimal and separate from name/range updates.
    # The independent GET below, rather than the CRUD refresh, proves trust.
    ignore_changes = [body.isTrusted]

    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.displayName))
      error_message = "displayName \"${var.displayName}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set displayName to a value that matches, or change name_pattern."
    }
  }
}

resource "terraform_data" "trust" {
  input = {
    id         = msgraph_resource.named_location.id
    is_trusted = var.isTrusted
  }
}

# The action sends this exact body, including the unchanged discriminator.
# Replacing the action sends one idempotent PATCH; its destroy is a no-op.
resource "msgraph_resource_action" "trust" {
  resource_url = "identity/conditionalAccess/namedLocations/${msgraph_resource.named_location.id}"
  api_version  = var.api_version
  method       = "PATCH"
  when         = "apply"
  body = {
    "@odata.type" = "#microsoft.graph.ipNamedLocation"
    isTrusted     = var.isTrusted
  }

  timeouts {
    create = var.timeouts.update
  }

  lifecycle {
    ignore_changes       = all
    replace_triggered_by = [terraform_data.trust, msgraph_resource.named_location]

    precondition {
      condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", msgraph_resource.named_location.id))
      error_message = "Refusing trust PATCH: the saved named-location ID must be a GUID."
    }
  }
}

# Poll only an independent GET, never a successful POST/PATCH or DELETE.
# A stale boolean is safe to reread; even if the retry deadline returns its
# last response, the postcondition below fails closed on that response.
data "msgraph_resource" "verify_trust" {
  url                    = "identity/conditionalAccess/namedLocations/${msgraph_resource.named_location.id}"
  api_version            = var.api_version
  response_export_values = { location = "@" }
  retry = {
    # A replica may not yet serve the just-created location (GB-msgraph-provider-611).
    # The 404 patterns are anchored to a Graph error envelope or a leading status line.
    error_message_regex = [
      var.isTrusted ? "\"isTrusted\"\\s*:\\s*false\\b" : "\"isTrusted\"\\s*:\\s*true\\b",
      "(?i)\"error\"\\s*:\\s*\\{[^}]*\"code\"\\s*:\\s*\"(404|NotFound|Request_ResourceNotFound)\"",
      "(?i)^(HTTP|status|statuscode)\\s*[:=]?\\s*404\\b",
    ]
  }
  timeouts {
    read = "2m"
  }
  depends_on = [msgraph_resource_action.trust]

  lifecycle {
    postcondition {
      condition = try(alltrue([
        self.output.location.id == msgraph_resource.named_location.id,
        self.output.location["@odata.type"] == "#microsoft.graph.ipNamedLocation",
        self.output.location.isTrusted == var.isTrusted,
      ]), false)
      error_message = "Independent GET did not confirm the exact IP named location and requested trust flag within two minutes. Do not destroy: retry unchanged apply to finish verification; if still trusted, preserve state and the run ownership journal for #208 recovery. A successful PATCH is not untrust proof."
    }
  }
}
