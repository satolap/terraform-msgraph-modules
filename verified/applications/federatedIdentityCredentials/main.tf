locals {
  application_id = lower(var.application-id)
  body = merge(
    {
      name      = var.name
      issuer    = var.issuer
      subject   = var.subject
      audiences = var.audiences
    },
    var.description == null ? {} : { description = var.description },
  )
}

# The provider does not infer replacement from a changed URL or immutable name.
# Default to delete first: the application enforces unique names and issuer/subject pairs
# and has a maximum of 20 credentials, so creating first may collide or exceed it.
# A dependent's create_before_destroy can override this ordering; see the README.
resource "terraform_data" "immutable" {
  input = {
    application_id = lower(var.application-id)
    name           = var.name
  }
}

# This is a child CRUD resource, not a one-shot action. POST runs only on create;
# mutable changes use PATCH, and DELETE addresses only the stored child id.
resource "msgraph_resource" "credential" {
  url                     = "applications/${terraform_data.immutable.input.application_id}/federatedIdentityCredentials"
  api_version             = "v1.0"
  body                    = local.body
  update_method           = "PATCH"
  ignore_missing_property = false

  response_export_values = {
    id   = "id"
    name = "name"
  }

  lifecycle {
    replace_triggered_by = [terraform_data.immutable]
    ignore_changes       = [body.name]

    # Never silently adopt a different identity returned by Graph. These checks
    # run after a provider operation; they are not pre-write import barriers.
    postcondition {
      condition     = try(can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", self.id)) ? lower(self.output.id) == lower(self.id) : false, false)
      error_message = "Graph must return this credential's GUID id, matching the provider's stored id. Missing or different identity evidence is refused. Do not import or adopt credentials."
    }

    postcondition {
      condition     = try(self.output.name == var.name, false)
      error_message = "Graph must return the configured immutable credential name. Missing or different identity evidence is refused; investigate before changing state."
    }
  }
}
