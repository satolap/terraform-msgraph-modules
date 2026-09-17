locals {
  add_body = {
    requestType = "adminAdd"
    catalog = {
      id = var.catalog_id
    }
    resource = merge(
      {
        originId     = var.resource_origin_id
        originSystem = var.resource_origin_system
      },
      var.resource_display_name != null ? { displayName = var.resource_display_name } : {},
    )
  }

  matched_resources   = try(data.msgraph_resource.verify.output.resources, [])
  matched_resource_id = try(local.matched_resources[0].id, null)
  verified            = length(local.matched_resources) == 1
}

# Adds the resource to the catalog via Microsoft Graph's action-style
# accessPackageResourceRequest API (there is no stable CRUD object for a
# catalog<->resource association, only adminAdd/adminRemove requests).
#
# msgraph_resource_action (not msgraph_resource) is used deliberately: an
# accessPackageResourceRequest supports neither PATCH nor DELETE, so managing
# it as a full CRUD resource would make `terraform destroy` fail when the
# provider attempts DELETE resourceRequests/{id}. The action resource performs
# the POST once at create and is simply forgotten on destroy; the actual
# removal from the catalog is handled by null_resource.remove_on_destroy below.
resource "msgraph_resource_action" "add_request" {
  resource_url = "identityGovernance/entitlementManagement/resourceRequests"
  method       = "POST"
  api_version  = var.api_version
  body         = local.add_body

  response_export_values = {
    request_id = "id"
    state      = "state"
  }
}

# Resource provisioning (especially for SharePoint Online sites) is
# asynchronous; wait before reading the catalog back to verify.
resource "time_sleep" "wait_for_delivery" {
  depends_on      = [msgraph_resource_action.add_request]
  create_duration = "${var.verification_delay_seconds}s"
}

# Reads the catalog's resources back, filtered by originId, both to verify
# the add succeeded and to capture the accessPackageResource's own `id`
# (distinct from resource_origin_id) needed by resourceRoleScopes and to
# submit an adminRemove on destroy.
data "msgraph_resource" "verify" {
  url         = "identityGovernance/entitlementManagement/catalogs/${var.catalog_id}/resources"
  api_version = var.api_version

  query_parameters = {
    "$filter" = ["originId eq '${replace(var.resource_origin_id, "'", "''")}' and originSystem eq '${var.resource_origin_system}'"]
  }

  response_export_values = {
    resources = "value"
  }

  depends_on = [time_sleep.wait_for_delivery]
}

# Hard-fails apply when fail_on_verification_mismatch is true and the
# resource wasn't found in the catalog after the verification delay.
resource "terraform_data" "verification_gate" {
  input = local.verified

  lifecycle {
    precondition {
      condition     = local.verified || !var.fail_on_verification_mismatch
      error_message = "Resource '${var.resource_origin_id}' (${var.resource_origin_system}) was not found in catalog '${var.catalog_id}' after ${var.verification_delay_seconds}s. It may still be provisioning; increase verification_delay_seconds and re-apply, or set fail_on_verification_mismatch = false."
    }
  }

  depends_on = [data.msgraph_resource.verify]
}

# Removal on destroy: Graph has no DELETE for a catalog resource
# association, only an adminRemove accessPackageResourceRequest. This uses
# the ambient Azure CLI session (the same auth the msgraph provider itself
# defaults to) to submit that request when the resource is destroyed.
# Values are passed as environment variables, never interpolated into shell code.
resource "null_resource" "remove_on_destroy" {
  count = var.enable_destroy_cleanup ? 1 : 0

  triggers = {
    catalog_id         = var.catalog_id
    resource_id        = local.matched_resource_id != null ? local.matched_resource_id : ""
    resource_origin_id = var.resource_origin_id
    api_version        = var.api_version
  }

  depends_on = [terraform_data.verification_gate]

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["bash", "-c"]
    environment = {
      GRAPH_CATALOG_ID  = self.triggers.catalog_id
      GRAPH_RESOURCE_ID = self.triggers.resource_id
      GRAPH_API_VERSION = self.triggers.api_version
      GRAPH_REMOVE_BODY = jsonencode({
        requestType = "adminRemove"
        catalog     = { id = self.triggers.catalog_id }
        resource    = { id = self.triggers.resource_id }
      })
    }
    command = <<-EOT
      set -euo pipefail
      test -n "$GRAPH_RESOURCE_ID" || { echo "ERROR: no catalog resource ID was captured; reconcile the catalog before destroying." >&2; exit 1; }
      TOKEN=$(az account get-access-token --resource https://graph.microsoft.com --query accessToken -o tsv)
      test -n "$TOKEN"
      curl --fail-with-body --silent --show-error --connect-timeout 30 --max-time 120 \
        -X POST "https://graph.microsoft.com/$GRAPH_API_VERSION/identityGovernance/entitlementManagement/resourceRequests" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/json" \
        --data "$GRAPH_REMOVE_BODY" >/dev/null
      echo "Submitted adminRemove for resource $GRAPH_RESOURCE_ID in catalog $GRAPH_CATALOG_ID. Delivery is asynchronous; verify removal in Graph."
    EOT
  }
}

moved {
  from = null_resource.remove_on_destroy
  to   = null_resource.remove_on_destroy[0]
}
