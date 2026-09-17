# /education/users

Create educationUser

[Catalog](../../../README.md) · [Education](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/educationuser?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /education/users`, `GET/PATCH/DELETE /education/users/{educationUser-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./education/education/users"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `account_enabled` | `accountEnabled` | `bool` | no | no |
| `assigned_licenses` | `assignedLicenses` | `list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     }))` | no | no |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignment")       addToCalendarAction = optional(any)       addedStudentAction = optional(any)       allowLateSubmissions = optional(bool)       allowStudentsToAddResourcesToSubmission = optional(bool)       assignTo = optional(any)       classId = optional(string)       closeDateTime = optional(string)       displayName = optional(string)       dueDateTime = optional(string)       grading = optional(any)       gradingCategory = optional(any)       gradingScheme = optional(any)       instructions = optional(any)       languageTag = optional(string)       moduleUrl = optional(string)       notificationChannelUrl = optional(string)       resources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignmentResource")       dependentResources = optional(any)       distributeForStudentWork = optional(bool)       resource = optional(any)     })))       rubric = optional(any)     }))` | no | no |
| `business_phones` | `businessPhones` | `list(string)` | no | no |
| `classes` | `classes` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationCategory")       displayName = optional(string)     })))       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignment")       addToCalendarAction = optional(any)       addedStudentAction = optional(any)       allowLateSubmissions = optional(bool)       allowStudentsToAddResourcesToSubmission = optional(bool)       assignTo = optional(any)       classId = optional(string)       closeDateTime = optional(string)       displayName = optional(string)       dueDateTime = optional(string)       grading = optional(any)       gradingCategory = optional(any)       gradingScheme = optional(any)       instructions = optional(any)       languageTag = optional(string)       moduleUrl = optional(string)       notificationChannelUrl = optional(string)       resources = optional(any)       rubric = optional(any)     })))       classCode = optional(string)       course = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(any)       assignments = optional(any)       businessPhones = optional(list(string))       classes = optional(any)       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(any)       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(any)       residenceAddress = optional(any)       rubrics = optional(any)       schools = optional(any)       showInAddressList = optional(bool)       student = optional(any)       surname = optional(string)       taughtClasses = optional(any)       teacher = optional(any)       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     })))       modules = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationModule")       description = optional(string)       displayName = optional(string)       isPinned = optional(bool)       languageTag = optional(string)       resources = optional(any)     })))       schools = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationSchool")       address = optional(any)       administrativeUnit = optional(any)       classes = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalPrincipalId = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       fax = optional(string)       highestGrade = optional(string)       lowestGrade = optional(string)       phone = optional(string)       principalEmail = optional(string)       principalName = optional(string)       schoolNumber = optional(string)       users = optional(any)     })))       teachers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(any)       assignments = optional(any)       businessPhones = optional(list(string))       classes = optional(any)       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(any)       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(any)       residenceAddress = optional(any)       rubrics = optional(any)       schools = optional(any)       showInAddressList = optional(bool)       student = optional(any)       surname = optional(string)       taughtClasses = optional(any)       teacher = optional(any)       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     })))       term = optional(any)     }))` | no | yes |
| `created_by` | `createdBy` | `any` | no | no |
| `department` | `department` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `external_source` | `externalSource` | `any` | no | no |
| `external_source_detail` | `externalSourceDetail` | `string` | no | no |
| `given_name` | `givenName` | `string` | no | no |
| `mail_nickname` | `mailNickname` | `string` | no | no |
| `mailing_address` | `mailingAddress` | `any` | no | no |
| `middle_name` | `middleName` | `string` | no | no |
| `mobile_phone` | `mobilePhone` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `office_location` | `officeLocation` | `string` | no | no |
| `on_premises_info` | `onPremisesInfo` | `any` | no | no |
| `password_policies` | `passwordPolicies` | `string` | no | yes |
| `password_profile` | `passwordProfile` | `any` | no | yes |
| `preferred_language` | `preferredLanguage` | `string` | no | no |
| `primary_role` | `primaryRole` | `string` | no | no |
| `refresh_tokens_valid_from_date_time` | `refreshTokensValidFromDateTime` | `string` | no | yes |
| `related_contacts` | `relatedContacts` | `list(object({       odata_type = optional(string, "#microsoft.graph.relatedContact")       accessConsent = optional(bool)       displayName = optional(string)       emailAddress = optional(string)       id = optional(string)       mobilePhone = optional(string)       relationship = optional(string)     }))` | no | no |
| `residence_address` | `residenceAddress` | `any` | no | no |
| `rubrics` | `rubrics` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationRubric")       description = optional(any)       displayName = optional(string)       grading = optional(any)       levels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.rubricLevel")       description = optional(any)       displayName = optional(string)       grading = optional(any)       levelId = optional(string)     })))       qualities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.rubricQuality")       criteria = optional(any)       description = optional(any)       displayName = optional(string)       qualityId = optional(string)       weight = optional(any)     })))     }))` | no | no |
| `schools` | `schools` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationSchool")       address = optional(any)       administrativeUnit = optional(any)       classes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(any)     })))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalPrincipalId = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       fax = optional(string)       highestGrade = optional(string)       lowestGrade = optional(string)       phone = optional(string)       principalEmail = optional(string)       principalName = optional(string)       schoolNumber = optional(string)       users = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(any)       assignments = optional(any)       businessPhones = optional(list(string))       classes = optional(any)       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(any)       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(any)       residenceAddress = optional(any)       rubrics = optional(any)       schools = optional(any)       showInAddressList = optional(bool)       student = optional(any)       surname = optional(string)       taughtClasses = optional(any)       teacher = optional(any)       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     })))     }))` | no | yes |
| `show_in_address_list` | `showInAddressList` | `bool` | no | no |
| `student` | `student` | `any` | no | no |
| `surname` | `surname` | `string` | no | no |
| `taught_classes` | `taughtClasses` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationCategory")       displayName = optional(string)     })))       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignment")       addToCalendarAction = optional(any)       addedStudentAction = optional(any)       allowLateSubmissions = optional(bool)       allowStudentsToAddResourcesToSubmission = optional(bool)       assignTo = optional(any)       classId = optional(string)       closeDateTime = optional(string)       displayName = optional(string)       dueDateTime = optional(string)       grading = optional(any)       gradingCategory = optional(any)       gradingScheme = optional(any)       instructions = optional(any)       languageTag = optional(string)       moduleUrl = optional(string)       notificationChannelUrl = optional(string)       resources = optional(any)       rubric = optional(any)     })))       classCode = optional(string)       course = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(any)       assignments = optional(any)       businessPhones = optional(list(string))       classes = optional(any)       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(any)       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(any)       residenceAddress = optional(any)       rubrics = optional(any)       schools = optional(any)       showInAddressList = optional(bool)       student = optional(any)       surname = optional(string)       taughtClasses = optional(any)       teacher = optional(any)       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     })))       modules = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationModule")       description = optional(string)       displayName = optional(string)       isPinned = optional(bool)       languageTag = optional(string)       resources = optional(any)     })))       schools = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationSchool")       address = optional(any)       administrativeUnit = optional(any)       classes = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalPrincipalId = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       fax = optional(string)       highestGrade = optional(string)       lowestGrade = optional(string)       phone = optional(string)       principalEmail = optional(string)       principalName = optional(string)       schoolNumber = optional(string)       users = optional(any)     })))       teachers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(any)       assignments = optional(any)       businessPhones = optional(list(string))       classes = optional(any)       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(any)       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(any)       residenceAddress = optional(any)       rubrics = optional(any)       schools = optional(any)       showInAddressList = optional(bool)       student = optional(any)       surname = optional(string)       taughtClasses = optional(any)       teacher = optional(any)       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     })))       term = optional(any)     }))` | no | yes |
| `teacher` | `teacher` | `any` | no | no |
| `usage_location` | `usageLocation` | `string` | no | no |
| `user` | `user` | `any` | no | no |
| `user_principal_name` | `userPrincipalName` | `string` | no | no |
| `user_type` | `userType` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- assignments[].addToCalendarAction: polymorphic schema; accepts an untyped value
- assignments[].addedStudentAction: polymorphic schema; accepts an untyped value
- assignments[].assignTo: polymorphic schema; accepts an untyped value
- assignments[].grading: polymorphic schema; accepts an untyped value
- assignments[].gradingCategory: polymorphic schema; accepts an untyped value
- assignments[].gradingScheme: polymorphic schema; accepts an untyped value
- assignments[].instructions: polymorphic schema; accepts an untyped value
- assignments[].resources[].dependentResources[]: recursive schema; accepts an untyped value
- assignments[].resources[].resource: polymorphic schema; accepts an untyped value
- assignments[].rubric: polymorphic schema; accepts an untyped value
- classes[].assignmentDefaults: polymorphic schema; accepts an untyped value
- classes[].assignmentSettings: polymorphic schema; accepts an untyped value
- classes[].assignments[].addToCalendarAction: polymorphic schema; accepts an untyped value
- classes[].assignments[].addedStudentAction: polymorphic schema; accepts an untyped value
- classes[].assignments[].assignTo: polymorphic schema; accepts an untyped value
- classes[].assignments[].grading: polymorphic schema; accepts an untyped value
- classes[].assignments[].gradingCategory: polymorphic schema; accepts an untyped value
- classes[].assignments[].gradingScheme: polymorphic schema; accepts an untyped value
- classes[].assignments[].instructions: polymorphic schema; accepts an untyped value
- classes[].assignments[].resources[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].assignments[].rubric: polymorphic schema; accepts an untyped value
- classes[].course: polymorphic schema; accepts an untyped value
- classes[].createdBy: polymorphic schema; accepts an untyped value
- classes[].externalSource: polymorphic schema; accepts an untyped value
- classes[].group: polymorphic schema; accepts an untyped value
- classes[].members[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].classes[]: recursive schema; accepts an untyped value
- classes[].members[].createdBy: polymorphic schema; accepts an untyped value
- classes[].members[].externalSource: polymorphic schema; accepts an untyped value
- classes[].members[].mailingAddress: polymorphic schema; accepts an untyped value
- classes[].members[].onPremisesInfo: polymorphic schema; accepts an untyped value
- classes[].members[].passwordProfile: polymorphic schema; accepts an untyped value
- classes[].members[].relatedContacts[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].residenceAddress: polymorphic schema; accepts an untyped value
- classes[].members[].rubrics[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].student: polymorphic schema; accepts an untyped value
- classes[].members[].taughtClasses[]: recursive schema; accepts an untyped value
- classes[].members[].teacher: polymorphic schema; accepts an untyped value
- classes[].members[].user: polymorphic schema; accepts an untyped value
- classes[].modules[].resources[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].schools[].address: polymorphic schema; accepts an untyped value
- classes[].schools[].administrativeUnit: polymorphic schema; accepts an untyped value
- classes[].schools[].classes[]: recursive schema; accepts an untyped value
- classes[].schools[].createdBy: polymorphic schema; accepts an untyped value
- classes[].schools[].externalSource: polymorphic schema; accepts an untyped value
- classes[].schools[].users[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].classes[]: recursive schema; accepts an untyped value
- classes[].teachers[].createdBy: polymorphic schema; accepts an untyped value
- classes[].teachers[].externalSource: polymorphic schema; accepts an untyped value
- classes[].teachers[].mailingAddress: polymorphic schema; accepts an untyped value
- classes[].teachers[].onPremisesInfo: polymorphic schema; accepts an untyped value
- classes[].teachers[].passwordProfile: polymorphic schema; accepts an untyped value
- classes[].teachers[].relatedContacts[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].residenceAddress: polymorphic schema; accepts an untyped value
- classes[].teachers[].rubrics[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].student: polymorphic schema; accepts an untyped value
- classes[].teachers[].taughtClasses[]: recursive schema; accepts an untyped value
- classes[].teachers[].teacher: polymorphic schema; accepts an untyped value
- classes[].teachers[].user: polymorphic schema; accepts an untyped value
- classes[].term: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- externalSource: polymorphic schema; accepts an untyped value
- mailingAddress: polymorphic schema; accepts an untyped value
- onPremisesInfo: polymorphic schema; accepts an untyped value
- passwordProfile: polymorphic schema; accepts an untyped value
- residenceAddress: polymorphic schema; accepts an untyped value
- rubrics[].description: polymorphic schema; accepts an untyped value
- rubrics[].grading: polymorphic schema; accepts an untyped value
- rubrics[].levels[].description: polymorphic schema; accepts an untyped value
- rubrics[].levels[].grading: polymorphic schema; accepts an untyped value
- rubrics[].qualities[].criteria[]: nested schema exceeds depth limit; accepts an untyped value
- rubrics[].qualities[].description: polymorphic schema; accepts an untyped value
- rubrics[].qualities[].weight: polymorphic schema; accepts an untyped value
- schools[].address: polymorphic schema; accepts an untyped value
- schools[].administrativeUnit: polymorphic schema; accepts an untyped value
- schools[].classes[].assignmentCategories[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].classes[].assignmentDefaults: polymorphic schema; accepts an untyped value
- schools[].classes[].assignmentSettings: polymorphic schema; accepts an untyped value
- schools[].classes[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].classes[].course: polymorphic schema; accepts an untyped value
- schools[].classes[].createdBy: polymorphic schema; accepts an untyped value
- schools[].classes[].externalSource: polymorphic schema; accepts an untyped value
- schools[].classes[].group: polymorphic schema; accepts an untyped value
- schools[].classes[].members[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].classes[].modules[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].classes[].schools[]: recursive schema; accepts an untyped value
- schools[].classes[].teachers[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].classes[].term: polymorphic schema; accepts an untyped value
- schools[].createdBy: polymorphic schema; accepts an untyped value
- schools[].externalSource: polymorphic schema; accepts an untyped value
- schools[].users[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].users[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].users[].classes[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].users[].createdBy: polymorphic schema; accepts an untyped value
- schools[].users[].externalSource: polymorphic schema; accepts an untyped value
- schools[].users[].mailingAddress: polymorphic schema; accepts an untyped value
- schools[].users[].onPremisesInfo: polymorphic schema; accepts an untyped value
- schools[].users[].passwordProfile: polymorphic schema; accepts an untyped value
- schools[].users[].relatedContacts[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].users[].residenceAddress: polymorphic schema; accepts an untyped value
- schools[].users[].rubrics[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].users[].schools[]: recursive schema; accepts an untyped value
- schools[].users[].student: polymorphic schema; accepts an untyped value
- schools[].users[].taughtClasses[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].users[].teacher: polymorphic schema; accepts an untyped value
- schools[].users[].user: polymorphic schema; accepts an untyped value
- student: polymorphic schema; accepts an untyped value
- taughtClasses[].assignmentDefaults: polymorphic schema; accepts an untyped value
- taughtClasses[].assignmentSettings: polymorphic schema; accepts an untyped value
- taughtClasses[].assignments[].addToCalendarAction: polymorphic schema; accepts an untyped value
- taughtClasses[].assignments[].addedStudentAction: polymorphic schema; accepts an untyped value
- taughtClasses[].assignments[].assignTo: polymorphic schema; accepts an untyped value
- taughtClasses[].assignments[].grading: polymorphic schema; accepts an untyped value
- taughtClasses[].assignments[].gradingCategory: polymorphic schema; accepts an untyped value
- taughtClasses[].assignments[].gradingScheme: polymorphic schema; accepts an untyped value
- taughtClasses[].assignments[].instructions: polymorphic schema; accepts an untyped value
- taughtClasses[].assignments[].resources[]: nested schema exceeds depth limit; accepts an untyped value
- taughtClasses[].assignments[].rubric: polymorphic schema; accepts an untyped value
- taughtClasses[].course: polymorphic schema; accepts an untyped value
- taughtClasses[].createdBy: polymorphic schema; accepts an untyped value
- taughtClasses[].externalSource: polymorphic schema; accepts an untyped value
- taughtClasses[].group: polymorphic schema; accepts an untyped value
- taughtClasses[].members[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- taughtClasses[].members[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- taughtClasses[].members[].classes[]: recursive schema; accepts an untyped value
- taughtClasses[].members[].createdBy: polymorphic schema; accepts an untyped value
- taughtClasses[].members[].externalSource: polymorphic schema; accepts an untyped value
- taughtClasses[].members[].mailingAddress: polymorphic schema; accepts an untyped value
- taughtClasses[].members[].onPremisesInfo: polymorphic schema; accepts an untyped value
- taughtClasses[].members[].passwordProfile: polymorphic schema; accepts an untyped value
- taughtClasses[].members[].relatedContacts[]: nested schema exceeds depth limit; accepts an untyped value
- taughtClasses[].members[].residenceAddress: polymorphic schema; accepts an untyped value
- taughtClasses[].members[].rubrics[]: nested schema exceeds depth limit; accepts an untyped value
- taughtClasses[].members[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- taughtClasses[].members[].student: polymorphic schema; accepts an untyped value
- taughtClasses[].members[].taughtClasses[]: recursive schema; accepts an untyped value
- taughtClasses[].members[].teacher: polymorphic schema; accepts an untyped value
- taughtClasses[].members[].user: polymorphic schema; accepts an untyped value
- taughtClasses[].modules[].resources[]: nested schema exceeds depth limit; accepts an untyped value
- taughtClasses[].schools[].address: polymorphic schema; accepts an untyped value
- taughtClasses[].schools[].administrativeUnit: polymorphic schema; accepts an untyped value
- taughtClasses[].schools[].classes[]: recursive schema; accepts an untyped value
- taughtClasses[].schools[].createdBy: polymorphic schema; accepts an untyped value
- taughtClasses[].schools[].externalSource: polymorphic schema; accepts an untyped value
- taughtClasses[].schools[].users[]: nested schema exceeds depth limit; accepts an untyped value
- taughtClasses[].teachers[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- taughtClasses[].teachers[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- taughtClasses[].teachers[].classes[]: recursive schema; accepts an untyped value
- taughtClasses[].teachers[].createdBy: polymorphic schema; accepts an untyped value
- taughtClasses[].teachers[].externalSource: polymorphic schema; accepts an untyped value
- taughtClasses[].teachers[].mailingAddress: polymorphic schema; accepts an untyped value
- taughtClasses[].teachers[].onPremisesInfo: polymorphic schema; accepts an untyped value
- taughtClasses[].teachers[].passwordProfile: polymorphic schema; accepts an untyped value
- taughtClasses[].teachers[].relatedContacts[]: nested schema exceeds depth limit; accepts an untyped value
- taughtClasses[].teachers[].residenceAddress: polymorphic schema; accepts an untyped value
- taughtClasses[].teachers[].rubrics[]: nested schema exceeds depth limit; accepts an untyped value
- taughtClasses[].teachers[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- taughtClasses[].teachers[].student: polymorphic schema; accepts an untyped value
- taughtClasses[].teachers[].taughtClasses[]: recursive schema; accepts an untyped value
- taughtClasses[].teachers[].teacher: polymorphic schema; accepts an untyped value
- taughtClasses[].teachers[].user: polymorphic schema; accepts an untyped value
- taughtClasses[].term: polymorphic schema; accepts an untyped value
- teacher: polymorphic schema; accepts an untyped value
- user: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
