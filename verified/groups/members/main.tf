locals {
  # A GUID has no case, but the provider compares member IDs as written and
  # stores them as Microsoft Graph returns them. An ID in another case would
  # show as a change on every plan, and the update would try to add it, which
  # Graph refuses because the object is already a member, and remove it under
  # the stored form, which removes the member. The module therefore uses every
  # ID in lower case, the form Microsoft Learn's response examples show. The
  # group ID is part of the url, and the provider replaces the collection when
  # the url changes, so it is lower-cased too: a change of case alone must
  # plan nothing.
  group_id   = lower(var.group-id)
  member_ids = [for id in var.member_ids : lower(id)]

  # Microsoft Learn documents that adding a member to a group created moments
  # before can return 400 Bad Request with "The source resource object or one
  # of the objects being referenced don't exist." until the group has
  # replicated, and says to retry after a brief delay. The provider retries a
  # 400 only when its message matches one of these expressions. The expression
  # stops before the apostrophe, which a JSON body may carry escaped.
  replication_delay_errors = [
    "The source resource object or one of the objects being referenced",
  ]
}

# The direct members of the group. The provider lists groups/{id}/members on
# every refresh, adds the IDs the list lacks one POST .../members/$ref each,
# and removes every other member one DELETE .../members/{id}/$ref each. It
# never uses the PATCH with members@odata.bind that adds up to 20 members in
# one request. collection_type is not set: microsoft/msgraph 0.3.0 to 0.5.0
# have no such argument and always reference directoryObjects/{id}, which is
# also the default from 0.6.0 on.
resource "msgraph_resource_collection" "this" {
  url           = "groups/${local.group_id}/members/$ref"
  api_version   = var.api_version
  reference_ids = local.member_ids

  retry = {
    error_message_regex = local.replication_delay_errors
  }

  timeouts {
    create = var.timeouts.create
    read   = var.timeouts.read
    update = var.timeouts.update
    delete = var.timeouts.delete
  }
}
