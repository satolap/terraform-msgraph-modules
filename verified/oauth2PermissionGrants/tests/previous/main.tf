# Legacy state-shape fixture from 6a537b36 (the cleanup provisioner is inert here).
locals {
  identity = {
    clientId    = lower(var.clientId)
    resourceId  = lower(var.resourceId)
    consentType = var.consentType
    principalId = var.principalId == null ? null : lower(var.principalId)
  }
  scope = join(" ", sort(tolist(var.scopes)))
}

# Only scope is documented for PATCH. GUID case alone never replaces a grant.
resource "terraform_data" "immutable" {
  input = local.identity
}

resource "msgraph_resource_action" "grant" {
  resource_url = "oauth2PermissionGrants"
  api_version  = "v1.0"
  method       = "POST"
  body         = merge(local.identity, { scope = local.scope })

  response_export_values = { grant = "@" }

  lifecycle {
    ignore_changes       = all
    replace_triggered_by = [terraform_data.immutable]

    precondition {
      condition     = var.consentType == "AllPrincipals" ? var.acknowledge_all_principals : true
      error_message = "AllPrincipals grants tenant-wide admin consent. Set acknowledge_all_principals = true only after reviewing the client, resource and scopes."
    }

    precondition {
      condition     = var.consentType == "Principal" ? var.principalId != null : var.principalId == null
      error_message = "Principal consent requires principalId; AllPrincipals requires principalId to be null."
    }

    postcondition {
      condition = try(alltrue([
        can(regex("^[A-Za-z0-9_-]{1,256}$", self.output.grant.id)),
        lower(self.output.grant.clientId) == local.identity.clientId,
        lower(self.output.grant.resourceId) == local.identity.resourceId,
        self.output.grant.consentType == local.identity.consentType,
        local.identity.principalId == null ? self.output.grant.principalId == null : lower(self.output.grant.principalId) == local.identity.principalId,
      ]), false)
      error_message = "Graph did not return the created grant ID and matching clientId, resourceId, consentType and principalId. Refusing incomplete or different ownership evidence."
    }
  }
}

# Capture ownership before the PATCH sidecar runs. Cleanup uses the old identity
# on replacement and is the only DELETE path; the POST action is merely forgotten.
resource "terraform_data" "owned" {
  input = merge(local.identity, { grantId = var.saved_id == null ? try(msgraph_resource_action.grant.output.grant.id, "") : var.saved_id })

  lifecycle {
    ignore_changes       = [input]
    replace_triggered_by = [msgraph_resource_action.grant]
  }

  # Legacy provisioner omitted: state shape is unchanged; no external cleanup can run offline.
}

# Idempotent, scope-only PATCH, including once after create. This resource never
# POSTs or DELETEs. The scope string is the complete desired set, not an addition.
resource "msgraph_update_resource" "scope" {
  url           = "oauth2PermissionGrants/${terraform_data.owned.input.grantId}"
  api_version   = "v1.0"
  update_method = "PATCH"
  body          = { scope = local.scope }

  lifecycle {
    replace_triggered_by = [msgraph_resource_action.grant]
  }
}
