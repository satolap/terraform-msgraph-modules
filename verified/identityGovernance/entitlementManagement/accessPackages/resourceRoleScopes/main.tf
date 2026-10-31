# Follows the documented Microsoft Graph flow for adding a resource role to an
# access package: list the roles of the resource in the catalog
# (catalogs/{id}/resourceRoles), pick the role, then POST a new
# resourceRoleScope on the access package referencing the catalog resource by
# its internal id. See:
# https://learn.microsoft.com/graph/api/accesspackage-post-resourcerolescopes
#
# Azure resource roles take a different path, below the role lookup.

locals {
  is_azure = var.resource_origin_system == "AzureResources"
}

data "msgraph_resource" "resource_roles" {
  count = local.is_azure ? 0 : 1

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
  available_roles = try(data.msgraph_resource.resource_roles[0].output.roles, [])

  # Match by originId when explicitly given, otherwise by display name
  # (case-insensitive), which is how roles are surfaced in the portal.
  matched_roles = var.role_origin_id != null ? [
    for r in local.available_roles : r if try(r.originId, null) == var.role_origin_id
    ] : [
    for r in local.available_roles : r if lower(try(r.displayName, "")) == lower(var.role_display_name)
  ]

  role_found = length(local.matched_roles) == 1
  role       = try(local.matched_roles[0], null)
}

# Azure resource roles cannot be listed. Graph answers the resourceRoles query
# above with 400 FunctionNotSupportedForOriginSystem for AzureResources, and a
# catalog resource's expanded roles hold only the roles that some access package
# already grants; the portal reads role definitions from Azure Resource Manager
# instead. The role is therefore named by its Azure role definition, and this
# read supplies the catalog resource's origin ID and its scopes: the root scope
# and, for a subscription, the resource groups Graph lists under it.
data "msgraph_resource" "azure_resource" {
  count = local.is_azure ? 1 : 0

  url         = "identityGovernance/entitlementManagement/catalogs/${var.catalog_id}/resources"
  api_version = var.api_version

  query_parameters = {
    "$filter" = ["id eq '${replace(var.catalog_resource_id, "'", "''")}'"]
    "$expand" = ["scopes"]
  }

  response_export_values = {
    resources = "value"
  }
}

locals {
  azure_resources          = try(data.msgraph_resource.azure_resource[0].output.resources, [])
  azure_resource_found     = length(local.azure_resources) == 1
  azure_resource_origin_id = try(local.azure_resources[0].originId, null)
  azure_resource_type = local.azure_resource_origin_id == null ? null : (
    can(regex("(?i)^/subscriptions/[^/]+$", local.azure_resource_origin_id)) ? "Subscription" :
    can(regex("(?i)^/providers/Microsoft\\.Management/managementGroups/[^/]+$", local.azure_resource_origin_id)) ? "ManagementGroup" : null
  )

  # The root scope by default, otherwise the listed scope with the requested
  # origin ID. Graph compares origin IDs without regard to letter case.
  available_scopes = try(local.azure_resources[0].scopes, [])
  matched_scopes = var.scope_origin_id == null ? [
    for s in local.available_scopes : s if try(s.isRootScope, false) == true
    ] : [
    for s in local.available_scopes : s if lower(try(s.originId, "")) == lower(var.scope_origin_id)
  ]
  azure_scope_found = length(local.matched_scopes) == 1
  azure_scope       = try(local.matched_scopes[0], null)

  # Role definition IDs in the forms Microsoft documents: under the
  # subscription for a subscription resource, which Azure Resource Manager
  # resolves for any role assignable there, and tenant-wide for a management
  # group, as Microsoft shows for a built-in role. A custom role assignable only
  # on a management group needs its listed ID through role_origin_id.
  azure_role_origin_id = var.role_origin_id != null ? var.role_origin_id : (
    var.role_definition_id == null || local.azure_resource_type == null ? null :
    local.azure_resource_type == "Subscription" ? "${local.azure_resource_origin_id}/providers/Microsoft.Authorization/roleDefinitions/${var.role_definition_id}" :
    "/providers/Microsoft.Authorization/roleDefinitions/${var.role_definition_id}"
  )
}

locals {
  role_origin_id = local.is_azure ? local.azure_role_origin_id : (
    var.role_origin_id != null ? var.role_origin_id : try(local.role.originId, null)
  )

  # The resource's own origin ID, taken from the expanded resource on the
  # matched role (or the Azure catalog resource); the default scope is the
  # resource's root scope.
  resource_origin_id = local.is_azure ? local.azure_resource_origin_id : try(local.role.resource.originId, null)
  scope_origin_id = local.is_azure ? try(local.azure_scope.originId, null) : (
    var.scope_origin_id != null ? var.scope_origin_id : local.resource_origin_id
  )
  is_root_scope = local.is_azure ? try(local.azure_scope.isRootScope, false) == true : var.scope_origin_id == null
  scope_display_name = var.scope_display_name != null ? var.scope_display_name : (
    local.is_azure ? try(local.azure_scope.displayName, "Root") : "Root"
  )

  # Azure roles add the role type, the resource type and the listed scope's id,
  # as in Microsoft's examples. Other origin systems keep their earlier body.
  body = {
    role = merge(
      {
        displayName  = local.is_azure ? var.role_display_name : try(local.role.displayName, var.role_display_name)
        originSystem = var.resource_origin_system
        originId     = local.role_origin_id
        resource = merge(
          {
            id           = var.catalog_resource_id
            originId     = local.resource_origin_id
            originSystem = var.resource_origin_system
          },
          local.is_azure ? { resourceType = local.azure_resource_type } : {},
        )
      },
      local.is_azure ? { type = var.role_type } : {},
    )
    scope = merge(
      {
        displayName  = local.scope_display_name
        originId     = local.scope_origin_id
        originSystem = var.resource_origin_system
        isRootScope  = local.is_root_scope
      },
      local.is_azure ? { id = try(local.azure_scope.id, null) } : {},
    )
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
# msgraph_resource_action.remove below.
resource "msgraph_resource_action" "resource_role_scope" {
  resource_url = "identityGovernance/entitlementManagement/accessPackages/${var.accessPackage-id}/resourceRoleScopes"
  method       = "POST"
  api_version  = var.api_version
  body         = local.body

  response_export_values = {
    id = "id"
  }

  lifecycle {
    ignore_changes       = all
    replace_triggered_by = [terraform_data.identity]

    precondition {
      condition     = local.is_azure || local.role_found
      error_message = "Expected exactly one matching role for catalog resource '${var.catalog_resource_id}'; found ${length(local.matched_roles)}. Inspect available_roles and set role_origin_id to disambiguate duplicate display names."
    }

    precondition {
      condition     = local.is_azure == (var.role_type != null)
      error_message = "Set role_type (\"active\" or \"eligible\") for AzureResources, and leave it null for other origin systems: Graph supports these role types only for Azure resource roles."
    }

    precondition {
      condition     = local.is_azure ? (var.role_definition_id == null) != (var.role_origin_id == null) : var.role_definition_id == null
      error_message = "For AzureResources, set exactly one of role_definition_id (the role definition GUID) or role_origin_id (the role definition's full resource ID). role_definition_id applies only to AzureResources."
    }

    precondition {
      condition     = !local.is_azure || (local.azure_resource_found && local.azure_resource_type != null)
      error_message = "Catalog resource '${var.catalog_resource_id}' was not found in catalog '${var.catalog_id}' as an Azure subscription or management group (found ${length(local.azure_resources)} matching resources). Pass the resource_id output of catalogs/resources for an AzureResources resource."
    }

    precondition {
      condition     = !local.is_azure || local.azure_scope_found
      error_message = "Found ${length(local.matched_scopes)} matching scopes on the Azure catalog resource. Leave scope_origin_id null for the root scope, or set it to a resource group that Graph lists for the subscription (/subscriptions/<subscription GUID>/resourceGroups/<name>); a management group has only its root scope. Inspect available_scopes."
    }
  }
}

# Creation inputs replace destroy-first; never replay the POST in place.
resource "terraform_data" "identity" {
  input = {
    access_package_id = var.accessPackage-id
    api_version       = var.api_version
    body              = local.body
  }
}

# The item GET is unsupported (GB-azure-rbac-508). Read the package's expanded
# collection and require the exact created ID and role/scope identity instead.
data "msgraph_resource" "verify_scope" {
  count = var.enable_destroy_cleanup ? 1 : 0

  url                    = "identityGovernance/entitlementManagement/accessPackages/${var.accessPackage-id}"
  api_version            = var.api_version
  query_parameters       = { "$expand" = ["resourceRoleScopes($expand=role,scope)"] }
  response_export_values = { package = "@" }
  retry = {
    error_message_regex = ["(?i)\"error\"\\s*:\\s*\\{[^}]*\"code\"\\s*:\\s*\"(404|NotFound|Request_ResourceNotFound)\"", "(?i)^(HTTP|status|statuscode)\\s*[:=]?\\s*404\\b"]
  }
  timeouts {
    read = "2m"
  }

  lifecycle {
    precondition {
      condition = alltrue([
        can(regex("(?i)^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", var.accessPackage-id)),
        can(regex("^[A-Za-z0-9_-]{1,512}$", try(msgraph_resource_action.resource_role_scope.output.id, ""))),
        var.api_version == null ? false : contains(["v1.0", "beta"], var.api_version),
      ])
      error_message = "Refusing verification: the package GUID, created scope ID and API version must form a safe URL."
    }
    postcondition {
      condition = try(alltrue([
        lower(self.output.package.id) == lower(var.accessPackage-id),
        try(self.output.package["resourceRoleScopes@odata.nextLink"], null) == null,
        try(self.output.package["@odata.nextLink"], null) == null,
        length([for scope in self.output.package.resourceRoleScopes : scope if scope.id == msgraph_resource_action.resource_role_scope.output.id]) == 1,
        alltrue([for scope in self.output.package.resourceRoleScopes : alltrue([
          lower(scope.role.originId) == lower(msgraph_resource_action.resource_role_scope.body.role.originId),
          scope.role.originSystem == msgraph_resource_action.resource_role_scope.body.role.originSystem,
          lower(scope.scope.originId) == lower(msgraph_resource_action.resource_role_scope.body.scope.originId),
          scope.scope.originSystem == msgraph_resource_action.resource_role_scope.body.scope.originSystem,
          scope.scope.isRootScope == msgraph_resource_action.resource_role_scope.body.scope.isRootScope,
          local.is_azure ? scope.scope.id == msgraph_resource_action.resource_role_scope.body.scope.id : true,
        ]) if scope.id == msgraph_resource_action.resource_role_scope.output.id]),
      ]), false)
      error_message = "Independent GET must prove exactly the created role-scope ID and its role and scope identity (role id/originId/originSystem and scope originId/originSystem/isRootScope as documented) in a complete collection. Reconcile the saved POST; do not replay it."
    }
  }
}

# Retain the legacy address and byte-identical triggers, without its provisioner.
# Its saved old ID remains the removal target during replacement.
resource "null_resource" "remove_on_destroy" {
  count = var.enable_destroy_cleanup ? 1 : 0

  triggers = {
    access_package_id = var.accessPackage-id
    role_scope_id     = try(msgraph_resource_action.resource_role_scope.output.id, "")
    api_version       = var.api_version
  }

  depends_on = [data.msgraph_resource.verify_scope]
}

resource "msgraph_resource_action" "remove" {
  count = var.enable_destroy_cleanup ? 1 : 0

  resource_url = "identityGovernance/entitlementManagement/accessPackages/${null_resource.remove_on_destroy[0].triggers.access_package_id}/resourceRoleScopes/${null_resource.remove_on_destroy[0].triggers.role_scope_id}"
  api_version  = null_resource.remove_on_destroy[0].triggers.api_version
  method       = "DELETE"
  when         = "destroy"

  lifecycle {
    ignore_changes       = all
    replace_triggered_by = [null_resource.remove_on_destroy]

    precondition {
      condition = alltrue([
        can(regex("(?i)^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", null_resource.remove_on_destroy[0].triggers.access_package_id)),
        can(regex("^[A-Za-z0-9_-]{1,512}$", null_resource.remove_on_destroy[0].triggers.role_scope_id)),
        null_resource.remove_on_destroy[0].triggers.api_version == null ? false : contains(["v1.0", "beta"], null_resource.remove_on_destroy[0].triggers.api_version),
        null_resource.remove_on_destroy[0].triggers.role_scope_id == msgraph_resource_action.resource_role_scope.output.id,
        null_resource.remove_on_destroy[0].triggers.access_package_id == var.accessPackage-id,
      ])
      error_message = "Refusing removal registration: saved URL segments must be safe and match the independently verified created scope."
    }
  }
}

moved {
  from = null_resource.remove_on_destroy
  to   = null_resource.remove_on_destroy[0]
}
