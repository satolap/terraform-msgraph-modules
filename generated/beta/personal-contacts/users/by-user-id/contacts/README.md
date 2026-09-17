# /users/{user-id}/contacts

Create new navigation property to contacts for users

[Catalog](../../../../README.md) · [Personal contacts](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/contact?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/contacts`, `GET/PATCH/DELETE /users/{user-id}/contacts/{contact-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./personal-contacts/users/by-user-id/contacts"
  user_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `assistant_name` | `assistantName` | `string` | no | no |
| `birthday` | `birthday` | `string` | no | no |
| `categories` | `categories` | `list(string)` | no | no |
| `children` | `children` | `list(string)` | no | no |
| `company_name` | `companyName` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `department` | `department` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `email_addresses` | `emailAddresses` | `list(object({       odata_type = optional(string, "#microsoft.graph.typedEmailAddress")       address = optional(string)       name = optional(string)       otherLabel = optional(string)       type = optional(any)     }))` | no | no |
| `extensions` | `extensions` | `list(object({       odata_type = optional(string, "#microsoft.graph.extension")     }))` | no | no |
| `file_as` | `fileAs` | `string` | no | no |
| `flag` | `flag` | `any` | no | no |
| `gender` | `gender` | `string` | no | no |
| `generation` | `generation` | `string` | no | no |
| `given_name` | `givenName` | `string` | no | no |
| `im_addresses` | `imAddresses` | `list(string)` | no | no |
| `initials` | `initials` | `string` | no | no |
| `is_favorite` | `isFavorite` | `bool` | no | no |
| `job_title` | `jobTitle` | `string` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `manager` | `manager` | `string` | no | no |
| `middle_name` | `middleName` | `string` | no | no |
| `nick_name` | `nickName` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `office_location` | `officeLocation` | `string` | no | no |
| `parent_folder_id` | `parentFolderId` | `string` | no | no |
| `personal_notes` | `personalNotes` | `string` | no | no |
| `phones` | `phones` | `list(object({       odata_type = optional(string, "#microsoft.graph.phone")       number = optional(string)       type = optional(any)     }))` | no | no |
| `photo` | `photo` | `any` | no | no |
| `postal_addresses` | `postalAddresses` | `list(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(any)     }))` | no | no |
| `primary_email_address` | `primaryEmailAddress` | `any` | no | no |
| `profession` | `profession` | `string` | no | no |
| `secondary_email_address` | `secondaryEmailAddress` | `any` | no | no |
| `spouse_name` | `spouseName` | `string` | no | no |
| `surname` | `surname` | `string` | no | no |
| `tertiary_email_address` | `tertiaryEmailAddress` | `any` | no | no |
| `title` | `title` | `string` | no | no |
| `websites` | `websites` | `list(object({       odata_type = optional(string, "#microsoft.graph.website")       address = optional(string)       displayName = optional(string)       type = optional(any)     }))` | no | no |
| `wedding_anniversary` | `weddingAnniversary` | `string` | no | no |
| `yomi_company_name` | `yomiCompanyName` | `string` | no | no |
| `yomi_given_name` | `yomiGivenName` | `string` | no | no |
| `yomi_surname` | `yomiSurname` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- emailAddresses[].type: polymorphic schema; accepts an untyped value
- flag: polymorphic schema; accepts an untyped value
- phones[].type: polymorphic schema; accepts an untyped value
- photo: polymorphic schema; accepts an untyped value
- postalAddresses[].type: polymorphic schema; accepts an untyped value
- primaryEmailAddress: polymorphic schema; accepts an untyped value
- secondaryEmailAddress: polymorphic schema; accepts an untyped value
- tertiaryEmailAddress: polymorphic schema; accepts an untyped value
- websites[].type: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
