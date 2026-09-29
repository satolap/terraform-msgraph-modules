output "id" {
  description = "The ID of the country named location. Pass it to a Conditional Access policy's locations.include_locations or locations.exclude_locations."
  value       = msgraph_resource.named_location.id
}

output "display_name" {
  description = "The display name Microsoft Graph returned on the last read."
  value       = msgraph_resource.named_location.output.display_name
}

output "countries_and_regions" {
  description = "The country and region codes Microsoft Graph returned on the last read, sorted."
  value       = try(sort(msgraph_resource.named_location.output.countries_and_regions), [])
}

output "include_unknown_countries_and_regions" {
  description = "Whether Microsoft Graph reported unknown countries and regions as included on the last read."
  value       = msgraph_resource.named_location.output.include_unknown_countries_and_regions
}

output "country_lookup_method" {
  description = "The lookup method Microsoft Graph returned on the last read."
  value       = msgraph_resource.named_location.output.country_lookup_method
}
