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

# Independently read the exact created item before recording ownership or
# registering deletion. Missing or mismatched identity fails closed.
data "msgraph_resource" "verify" {
  url                    = "${msgraph_resource_action.grant.resource_url}/${msgraph_resource_action.grant.output.grant.id}"
  api_version            = "v1.0"
  response_export_values = { grant = "@" }

  # A just-created item may not be visible on the read replica yet. Retry only
  # this GET, never POST or DELETE; the explicit timeout bounds replication wait.
  retry = {
    error_message_regex = ["(?i)\"error\"\\s*:\\s*\\{[^}]*\"code\"\\s*:\\s*\"(404|NotFound|Request_ResourceNotFound)\"", "(?i)^(HTTP|status|statuscode)\\s*[:=]?\\s*404\\b"]
  }
  timeouts {
    read = "2m"
  }

  lifecycle {
    postcondition {
      condition = try(alltrue([
        self.output.grant.id == msgraph_resource_action.grant.output.grant.id,
        lower(self.output.grant.clientId) == lower(msgraph_resource_action.grant.output.grant.clientId),
        lower(self.output.grant.resourceId) == lower(msgraph_resource_action.grant.output.grant.resourceId),
        self.output.grant.consentType == msgraph_resource_action.grant.output.grant.consentType,
        msgraph_resource_action.grant.output.grant.principalId == null ? self.output.grant.principalId == null : lower(self.output.grant.principalId) == lower(msgraph_resource_action.grant.output.grant.principalId),
      ]), false)
      error_message = "The independent GET did not verify the created grant ID and immutable identity. Deletion registration fails closed; reconcile the captured POST response before retrying."
    }
  }
}

# Capture ownership only after the independent GET succeeds. This record and
# the destroy-only action retain the old identity during replacement.
resource "terraform_data" "owned" {
  input = merge(local.identity, { grantId = try(msgraph_resource_action.grant.output.grant.id, "") })

  depends_on = [data.msgraph_resource.verify]

  lifecycle {
    ignore_changes       = [input]
    replace_triggered_by = [msgraph_resource_action.grant]
  }
}

# Registration sends no request. Destroy/replacement deletes only this saved ID
# using the provider credentials; it does not re-read identity or prove absence.
resource "msgraph_resource_action" "remove" {
  resource_url = "oauth2PermissionGrants/${terraform_data.owned.input.grantId}"
  api_version  = "v1.0"
  method       = "DELETE"
  when         = "destroy"

  lifecycle {
    ignore_changes       = all
    replace_triggered_by = [terraform_data.owned]

    precondition {
      condition     = can(regex("^[A-Za-z0-9_-]{1,256}$", terraform_data.owned.input.grantId))
      error_message = "Refusing deletion registration: the saved item ID must be URL-safe. Reconcile ownership state without widening the DELETE URL."
    }
  }
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
