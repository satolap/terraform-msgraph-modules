locals {
  # Role definition IDs from Microsoft Learn, "Entitlement management roles"
  # (entitlement-management-delegate). Catalog creator is tenant-wide; the
  # others are defined for each catalog. The Connected Organization
  # Administrator is absent on purpose: Learn prints a malformed ID for it.
  tenant_roles = {
    catalog_creator = "ba92d953-d8e0-4e39-a797-0cbedb0a89e8"
  }

  catalog_roles = {
    catalog_owner                     = "ae79f266-94d4-4dab-b730-feca7e132178"
    catalog_reader                    = "44272f93-9762-48e8-af59-1b5351b1d6b3"
    access_package_manager            = "7f480852-ebdc-47d4-87de-0d8498384a83"
    access_package_assignment_manager = "e2182095-804a-4656-ae11-64734e9b7ae5"
  }

  named_role_ids = merge(local.tenant_roles, local.catalog_roles)

  role_label = var.role == null ? "" : var.role

  # GUIDs have no case, and Microsoft Graph answers with lower-case IDs. The
  # body and the replacement trigger use lower case, so an input written in
  # upper case does not show as drift and plan an in-place update that this
  # endpoint does not support.
  principal_id = lower(var.principal_id)
  catalog_id   = var.catalog_id == null ? null : lower(var.catalog_id)

  role_definition_id = var.role != null ? lookup(local.named_role_ids, var.role, null) : (var.role_definition_id == null ? null : lower(var.role_definition_id))

  # A named role fixes its scope. A raw role definition ID takes the catalog
  # when catalog_id is set and the tenant otherwise.
  is_catalog_scope = var.role != null ? contains(keys(local.catalog_roles), var.role) : var.catalog_id != null

  app_scope_id       = local.is_catalog_scope && var.catalog_id != null ? "/AccessPackageCatalog/${local.catalog_id}" : null
  directory_scope_id = local.is_catalog_scope ? null : "/"

  body = merge(
    {
      principalId      = local.principal_id
      roleDefinitionId = local.role_definition_id
    },
    local.is_catalog_scope ? { appScopeId = local.app_scope_id } : { directoryScopeId = local.directory_scope_id },
  )
}

# A unifiedRoleAssignment cannot be updated, and Graph refuses a second
# assignment of the same principal, role and scope. Every input therefore
# replaces the assignment, and the replacement deletes the old assignment
# before creating the new one: create_before_destroy would be refused as a
# duplicate when only the api_version changes.
resource "terraform_data" "immutable" {
  input = {
    principal_id       = local.principal_id
    role_definition_id = local.role_definition_id
    app_scope_id       = local.app_scope_id
    directory_scope_id = local.directory_scope_id
    api_version        = var.api_version
  }
}

# Microsoft Learn documents create, get and delete of a unifiedRoleAssignment
# for the entitlement management provider, so this is a plain CRUD resource.
resource "msgraph_resource" "assignment" {
  url         = "roleManagement/entitlementManagement/roleAssignments"
  api_version = var.api_version
  body        = local.body

  # Graph answers with properties the body does not send (such as a null
  # directoryScopeId for a catalog scope); they are not drift.
  ignore_missing_property = true

  lifecycle {
    replace_triggered_by = [terraform_data.immutable]

    precondition {
      condition     = (var.role != null) != (var.role_definition_id != null)
      error_message = "Set exactly one of role (${join(", ", keys(local.named_role_ids))}) or role_definition_id."
    }

    precondition {
      # A conditional, not ||: older Terraform evaluates both operands of || and
      # rejects the null role passed to contains.
      condition     = var.role == null ? true : (!contains(keys(local.catalog_roles), var.role) || var.catalog_id != null)
      error_message = "The role \"${local.role_label}\" is defined for each catalog: set catalog_id to the catalog it applies to."
    }

    precondition {
      condition     = var.role == null ? true : (!contains(keys(local.tenant_roles), var.role) || var.catalog_id == null)
      error_message = "The role \"${local.role_label}\" is tenant-wide and cannot be limited to a catalog: leave catalog_id null."
    }
  }
}
