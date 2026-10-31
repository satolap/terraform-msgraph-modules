locals {
  # Entitlement management onboards an Azure subscription or management group,
  # never a resource group, and the request names which with resourceType. The
  # documented origin ID formats decide it; Graph matches origin IDs without
  # regard to letter case, so neither pattern does either.
  azure_resource_type = var.resource_origin_system != "AzureResources" ? null : (
    can(regex("(?i)^/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.resource_origin_id)) ? "Subscription" :
    can(regex("(?i)^/providers/Microsoft\\.Management/managementGroups/[^/]+$", var.resource_origin_id)) ? "ManagementGroup" : null
  )

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
      local.azure_resource_type != null ? { resourceType = local.azure_resource_type } : {},
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

  lifecycle {
    precondition {
      condition     = var.resource_origin_system != "AzureResources" || local.azure_resource_type != null
      error_message = "For AzureResources, resource_origin_id must be a subscription (/subscriptions/<subscription GUID>) or a management group (/providers/Microsoft.Management/managementGroups/<management group ID>). A resource group cannot be added to a catalog: add its subscription, then scope the role to the resource group in access-packages/resource-role-scopes."
    }
  }
}

# The values that name the catalog, the resource and the endpoint of the
# adminAdd request. A change to one of them submits a new adminAdd: a new
# api_version replaces add_request, and a new catalog or resource updates it,
# which the provider does by running the action again.
resource "terraform_data" "add_target" {
  input = {
    catalog_id             = var.catalog_id
    resource_origin_id     = var.resource_origin_id
    resource_origin_system = var.resource_origin_system
    api_version            = var.api_version
  }
}

# Resource provisioning (especially for SharePoint Online sites) is
# asynchronous; wait before reading the catalog back to verify.
#
# A new adminAdd waits again: a change to add_target replaces this sleep, which
# defers the verification read to apply, after the new delay. Before this
# trigger, the sleep was created once, so the read ran at plan time against the
# new catalog or resource, before the new request was even submitted. The
# trigger leaves out resource_display_name: a change to it alone runs the
# action again for a resource that is already in the catalog, and replacing the
# sleep would leave resource_id unknown until apply, which replaces the destroy
# hook and removes the resource. The first apply of a module version that adds
# add_target only creates it, so upgrading does not replace the sleep.
resource "time_sleep" "wait_for_delivery" {
  depends_on      = [msgraph_resource_action.add_request]
  create_duration = "${var.verification_delay_seconds}s"

  lifecycle {
    replace_triggered_by = [terraform_data.add_target]
  }
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
# the ambient Azure CLI session to submit that request when the resource is
# destroyed. Before requesting a token it requires ARM_TENANT_ID (the tenant
# variable the msgraph provider reads) to match `az account show`, so the
# request cannot go to another tenant. curl reads the Authorization header
# from a config on stdin, so the token never appears in a process argv.
# Values are passed as environment variables, never interpolated into shell code.
# Graph refuses the removal while an access package in the catalog still uses
# the resource, and can keep refusing it briefly after the access package is
# deleted, so 400, 409, 429 and 5xx answers are retried for about two minutes.
# Each refusal prints Graph's error body, with control characters removed.
# Keep `triggers` unchanged: a change replaces this resource and runs the cleanup.
resource "null_resource" "remove_on_destroy" {
  count = var.enable_destroy_cleanup ? 1 : 0

  triggers = {
    catalog_id         = var.catalog_id
    resource_id        = local.matched_resource_id != null ? local.matched_resource_id : ""
    resource_origin_id = var.resource_origin_id
    api_version        = var.api_version
  }

  depends_on = [terraform_data.verification_gate]

  # Legacy provisioner omitted offline; state shape and triggers are preserved.
}

moved {
  from = null_resource.remove_on_destroy
  to   = null_resource.remove_on_destroy[0]
}
