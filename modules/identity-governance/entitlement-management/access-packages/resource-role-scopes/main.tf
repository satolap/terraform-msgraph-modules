# Follows the documented Microsoft Graph flow for adding a resource role to an
# access package: list the roles of the resource in the catalog
# (catalogs/{id}/resourceRoles), pick the role, then POST a new
# resourceRoleScope on the access package referencing the catalog resource by
# its internal id. See:
# https://learn.microsoft.com/graph/api/accesspackage-post-resourcerolescopes

data "msgraph_resource" "resource_roles" {
  url         = "identityGovernance/entitlementManagement/catalogs/${var.catalog_id}/resourceRoles"
  api_version = var.api_version

  query_parameters = {
    "$filter" = ["(originSystem eq '${var.resource_origin_system}' and resource/id eq '${replace(var.catalog_resource_id, "'", "''")}')"]
    "$expand" = ["resource"]
  }

  response_export_values = {
    roles = "value"
  }
}

locals {
  available_roles = try(data.msgraph_resource.resource_roles.output.roles, [])

  # Match by originId when explicitly given, otherwise by display name
  # (case-insensitive), which is how roles are surfaced in the portal.
  matched_roles = var.role_origin_id != null ? [
    for r in local.available_roles : r if try(r.originId, null) == var.role_origin_id
    ] : [
    for r in local.available_roles : r if lower(try(r.displayName, "")) == lower(var.role_display_name)
  ]

  role_found     = length(local.matched_roles) == 1
  role           = try(local.matched_roles[0], null)
  role_origin_id = var.role_origin_id != null ? var.role_origin_id : try(local.role.originId, null)

  # The resource's own origin ID, taken from the expanded resource on the
  # matched role; the default scope is the resource's root scope.
  resource_origin_id = try(local.role.resource.originId, null)
  scope_origin_id    = var.scope_origin_id != null ? var.scope_origin_id : local.resource_origin_id
  is_root_scope      = var.scope_origin_id == null

  body = {
    role = {
      displayName  = try(local.role.displayName, var.role_display_name)
      originSystem = var.resource_origin_system
      originId     = local.role_origin_id
      resource = {
        id           = var.catalog_resource_id
        originId     = local.resource_origin_id
        originSystem = var.resource_origin_system
      }
    }
    scope = {
      displayName  = var.scope_display_name != null ? var.scope_display_name : "Root"
      originId     = local.scope_origin_id
      originSystem = var.resource_origin_system
      isRootScope  = local.is_root_scope
    }
  }
}

# Creates the role scope with a one-shot POST. msgraph_resource_action (not
# msgraph_resource) is used deliberately: Microsoft Graph exposes
# resourceRoleScopes as a list-only relationship of the access package. The
# POST succeeds immediately and the entry appears in
# GET accessPackages/{id}/resourceRoleScopes, but reading a single entry —
# GET .../resourceRoleScopes/{id} — returns 404 ("No HTTP resource was found
# that matches the request URI"). msgraph_resource's create flow reads the
# new resource back by id after POSTing, so it treats that 404 as "still
# provisioning" and polls until the create timeout: the apply hangs on
# "Still creating..." forever. DELETE .../resourceRoleScopes/{id} *is*
# supported (verified against v1.0), so removal is handled by
# null_resource.remove_on_destroy below.
resource "msgraph_resource_action" "resource_role_scope" {
  resource_url = "identityGovernance/entitlementManagement/accessPackages/${var.access_package_id}/resourceRoleScopes"
  method       = "POST"
  api_version  = var.api_version
  body         = local.body

  response_export_values = {
    id = "id"
  }

  lifecycle {
    precondition {
      condition     = local.role_found
      error_message = "Expected exactly one matching role for catalog resource '${var.catalog_resource_id}'; found ${length(local.matched_roles)}. Inspect available_roles and set role_origin_id to disambiguate duplicate display names."
    }
  }
}

# Deletes the role scope on destroy. Same pattern as the catalogs/resources
# module: the one-shot action above is simply forgotten on destroy, so the
# actual DELETE goes through the ambient Azure CLI session (the same auth the
# msgraph provider itself defaults to). 404 is tolerated — the role scope
# disappears with its access package if that was destroyed first.
resource "null_resource" "remove_on_destroy" {
  count = var.enable_destroy_cleanup ? 1 : 0

  triggers = {
    access_package_id = var.access_package_id
    role_scope_id     = try(msgraph_resource_action.resource_role_scope.output.id, "")
    api_version       = var.api_version
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["bash", "-c"]
    environment = {
      GRAPH_ACCESS_PACKAGE_ID = self.triggers.access_package_id
      GRAPH_ROLE_SCOPE_ID     = self.triggers.role_scope_id
      GRAPH_API_VERSION       = self.triggers.api_version
    }
    command = <<-EOT
      set -euo pipefail
      test -n "$GRAPH_ROLE_SCOPE_ID" || { echo "ERROR: no role scope ID was captured; reconcile the access package before destroying." >&2; exit 1; }
      TOKEN=$(az account get-access-token --resource https://graph.microsoft.com --query accessToken -o tsv)
      test -n "$TOKEN"
      status=$(curl --silent --show-error --connect-timeout 30 --max-time 120 -o /dev/null -w "%%{http_code}" -X DELETE \
        "https://graph.microsoft.com/$GRAPH_API_VERSION/identityGovernance/entitlementManagement/accessPackages/$GRAPH_ACCESS_PACKAGE_ID/resourceRoleScopes/$GRAPH_ROLE_SCOPE_ID" \
        -H "Authorization: Bearer $TOKEN")
      case "$status" in
        200|204|404) echo "Removed role scope $GRAPH_ROLE_SCOPE_ID from access package $GRAPH_ACCESS_PACKAGE_ID (HTTP $status)" ;;
        *) echo "ERROR: DELETE of role scope $GRAPH_ROLE_SCOPE_ID returned HTTP $status" >&2; exit 1 ;;
      esac
    EOT
  }
}

moved {
  from = null_resource.remove_on_destroy
  to   = null_resource.remove_on_destroy[0]
}
