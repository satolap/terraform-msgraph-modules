# /bookingBusinesses/{bookingBusiness-id}/appointments

Create new navigation property to appointments for bookingBusinesses

[Catalog](../../../../README.md) · [Customer booking](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/bookingappointment?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /bookingBusinesses/{bookingBusiness-id}/appointments`, `GET/PATCH/DELETE /bookingBusinesses/{bookingBusiness-id}/appointments/{bookingAppointment-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./customer-booking/booking-businesses/by-booking-business-id/appointments"
  booking_business_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `booking_business_id` | URL parameter `bookingBusiness-id` | `string` | yes | no |
| `additional_information` | `additionalInformation` | `string` | no | no |
| `anonymous_join_web_url` | `anonymousJoinWebUrl` | `string` | no | no |
| `appointment_label` | `appointmentLabel` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `customer_email_address` | `customerEmailAddress` | `string` | no | no |
| `customer_id` | `customerId` | `string` | no | no |
| `customer_location` | `customerLocation` | `any` | no | no |
| `customer_name` | `customerName` | `string` | no | no |
| `customer_notes` | `customerNotes` | `string` | no | no |
| `customer_phone` | `customerPhone` | `string` | no | no |
| `customer_time_zone` | `customerTimeZone` | `string` | no | no |
| `customers` | `customers` | `list(object({       odata_type = optional(string, "#microsoft.graph.bookingCustomerInformationBase")     }))` | no | no |
| `end` | `end` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     })` | no | no |
| `invoice_amount` | `invoiceAmount` | `any` | no | no |
| `invoice_date` | `invoiceDate` | `any` | no | no |
| `invoice_id` | `invoiceId` | `string` | no | no |
| `invoice_status` | `invoiceStatus` | `string` | no | no |
| `invoice_url` | `invoiceUrl` | `string` | no | no |
| `is_customer_allowed_to_manage_booking` | `isCustomerAllowedToManageBooking` | `bool` | no | no |
| `is_location_online` | `isLocationOnline` | `bool` | no | no |
| `join_web_url` | `joinWebUrl` | `string` | no | no |
| `last_updated_date_time` | `lastUpdatedDateTime` | `string` | no | no |
| `maximum_attendees_count` | `maximumAttendeesCount` | `number` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `online_meeting_url` | `onlineMeetingUrl` | `string` | no | no |
| `opt_out_of_customer_email` | `optOutOfCustomerEmail` | `bool` | no | no |
| `post_buffer` | `postBuffer` | `string` | no | no |
| `pre_buffer` | `preBuffer` | `string` | no | no |
| `price` | `price` | `any` | no | no |
| `price_type` | `priceType` | `string` | no | no |
| `reminders` | `reminders` | `list(object({       odata_type = optional(string, "#microsoft.graph.bookingReminder")       message = optional(string)       offset = optional(string)       recipients = optional(string)     }))` | no | no |
| `self_service_appointment_id` | `selfServiceAppointmentId` | `string` | no | no |
| `service_id` | `serviceId` | `string` | no | no |
| `service_location` | `serviceLocation` | `any` | no | no |
| `service_name` | `serviceName` | `string` | no | no |
| `service_notes` | `serviceNotes` | `string` | no | no |
| `sms_notifications_enabled` | `smsNotificationsEnabled` | `bool` | no | no |
| `staff_member_ids` | `staffMemberIds` | `list(string)` | no | no |
| `start` | `start` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     })` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- customerLocation: polymorphic schema; accepts an untyped value
- invoiceAmount: polymorphic schema; accepts an untyped value
- invoiceDate: polymorphic schema; accepts an untyped value
- price: polymorphic schema; accepts an untyped value
- serviceLocation: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
