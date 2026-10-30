output "id" {
  description = "The ID of the IP named location. Pass it to a Conditional Access policy's locations.include_locations or locations.exclude_locations."
  value       = msgraph_resource.named_location.id
}

output "display_name" {
  description = "The display name Microsoft Graph returned on the last read."
  value       = msgraph_resource.named_location.output.display_name
}

output "is_trusted" {
  description = "Whether Microsoft Graph reported the location as trusted on the last read."
  value       = msgraph_resource.named_location.output.is_trusted
}

output "ip_ranges" {
  description = "The CIDR ranges Microsoft Graph returned on the last read, sorted."
  value       = try(sort(msgraph_resource.named_location.output.ip_ranges), [])
}
