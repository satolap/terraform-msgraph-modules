# /education/classes

Create educationClass

[Catalog](../../../README.md) · [Education](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/educationclass?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /education/classes`, `GET/PATCH/DELETE /education/classes/{educationClass-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./education/education/classes"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `assignment_categories` | `assignmentCategories` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationCategory")       displayName = optional(string)     }))` | no | no |
| `assignment_defaults` | `assignmentDefaults` | `any` | no | no |
| `assignment_settings` | `assignmentSettings` | `any` | no | no |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignment")       addToCalendarAction = optional(any)       addedStudentAction = optional(any)       allowLateSubmissions = optional(bool)       allowStudentsToAddResourcesToSubmission = optional(bool)       assignTo = optional(any)       classId = optional(string)       closeDateTime = optional(string)       displayName = optional(string)       dueDateTime = optional(string)       grading = optional(any)       gradingCategory = optional(any)       gradingScheme = optional(any)       instructions = optional(any)       languageTag = optional(string)       moduleUrl = optional(string)       notificationChannelUrl = optional(string)       resources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignmentResource")       dependentResources = optional(any)       distributeForStudentWork = optional(bool)       resource = optional(any)     })))       rubric = optional(any)     }))` | no | no |
| `class_code` | `classCode` | `string` | no | no |
| `course` | `course` | `any` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `external_id` | `externalId` | `string` | no | no |
| `external_name` | `externalName` | `string` | no | no |
| `external_source` | `externalSource` | `any` | no | no |
| `external_source_detail` | `externalSourceDetail` | `string` | no | no |
| `grade` | `grade` | `string` | no | no |
| `group` | `group` | `any` | no | no |
| `mail_nickname` | `mailNickname` | `string` | no | no |
| `members` | `members` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignment")       addToCalendarAction = optional(any)       addedStudentAction = optional(any)       allowLateSubmissions = optional(bool)       allowStudentsToAddResourcesToSubmission = optional(bool)       assignTo = optional(any)       classId = optional(string)       closeDateTime = optional(string)       displayName = optional(string)       dueDateTime = optional(string)       grading = optional(any)       gradingCategory = optional(any)       gradingScheme = optional(any)       instructions = optional(any)       languageTag = optional(string)       moduleUrl = optional(string)       notificationChannelUrl = optional(string)       resources = optional(any)       rubric = optional(any)     })))       businessPhones = optional(list(string))       classes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(any)     })))       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(any)       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.relatedContact")       accessConsent = optional(bool)       displayName = optional(string)       emailAddress = optional(string)       id = optional(string)       mobilePhone = optional(string)       relationship = optional(string)     })))       residenceAddress = optional(any)       rubrics = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationRubric")       description = optional(any)       displayName = optional(string)       grading = optional(any)       levels = optional(any)       qualities = optional(any)     })))       schools = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationSchool")       address = optional(any)       administrativeUnit = optional(any)       classes = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalPrincipalId = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       fax = optional(string)       highestGrade = optional(string)       lowestGrade = optional(string)       phone = optional(string)       principalEmail = optional(string)       principalName = optional(string)       schoolNumber = optional(string)       users = optional(any)     })))       showInAddressList = optional(bool)       student = optional(any)       surname = optional(string)       taughtClasses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(any)     })))       teacher = optional(any)       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     }))` | no | yes |
| `modules` | `modules` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationModule")       description = optional(string)       displayName = optional(string)       isPinned = optional(bool)       languageTag = optional(string)       resources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationModuleResource")       resource = optional(any)     })))     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `schools` | `schools` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationSchool")       address = optional(any)       administrativeUnit = optional(any)       classes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(any)     })))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalPrincipalId = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       fax = optional(string)       highestGrade = optional(string)       lowestGrade = optional(string)       phone = optional(string)       principalEmail = optional(string)       principalName = optional(string)       schoolNumber = optional(string)       users = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(any)       assignments = optional(any)       businessPhones = optional(list(string))       classes = optional(any)       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(any)       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(any)       residenceAddress = optional(any)       rubrics = optional(any)       schools = optional(any)       showInAddressList = optional(bool)       student = optional(any)       surname = optional(string)       taughtClasses = optional(any)       teacher = optional(any)       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     })))     }))` | no | yes |
| `teachers` | `teachers` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignment")       addToCalendarAction = optional(any)       addedStudentAction = optional(any)       allowLateSubmissions = optional(bool)       allowStudentsToAddResourcesToSubmission = optional(bool)       assignTo = optional(any)       classId = optional(string)       closeDateTime = optional(string)       displayName = optional(string)       dueDateTime = optional(string)       grading = optional(any)       gradingCategory = optional(any)       gradingScheme = optional(any)       instructions = optional(any)       languageTag = optional(string)       moduleUrl = optional(string)       notificationChannelUrl = optional(string)       resources = optional(any)       rubric = optional(any)     })))       businessPhones = optional(list(string))       classes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(any)     })))       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(any)       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(any)       passwordPolicies = optional(string)       passwordProfile = optional(any)       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.relatedContact")       accessConsent = optional(bool)       displayName = optional(string)       emailAddress = optional(string)       id = optional(string)       mobilePhone = optional(string)       relationship = optional(string)     })))       residenceAddress = optional(any)       rubrics = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationRubric")       description = optional(any)       displayName = optional(string)       grading = optional(any)       levels = optional(any)       qualities = optional(any)     })))       schools = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationSchool")       address = optional(any)       administrativeUnit = optional(any)       classes = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalPrincipalId = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       fax = optional(string)       highestGrade = optional(string)       lowestGrade = optional(string)       phone = optional(string)       principalEmail = optional(string)       principalName = optional(string)       schoolNumber = optional(string)       users = optional(any)     })))       showInAddressList = optional(bool)       student = optional(any)       surname = optional(string)       taughtClasses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(any)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(any)     })))       teacher = optional(any)       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     }))` | no | yes |
| `term` | `term` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- assignmentDefaults: polymorphic schema; accepts an untyped value
- assignmentSettings: polymorphic schema; accepts an untyped value
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
- course: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- externalSource: polymorphic schema; accepts an untyped value
- group: polymorphic schema; accepts an untyped value
- members[].assignments[].addToCalendarAction: polymorphic schema; accepts an untyped value
- members[].assignments[].addedStudentAction: polymorphic schema; accepts an untyped value
- members[].assignments[].assignTo: polymorphic schema; accepts an untyped value
- members[].assignments[].grading: polymorphic schema; accepts an untyped value
- members[].assignments[].gradingCategory: polymorphic schema; accepts an untyped value
- members[].assignments[].gradingScheme: polymorphic schema; accepts an untyped value
- members[].assignments[].instructions: polymorphic schema; accepts an untyped value
- members[].assignments[].resources[]: nested schema exceeds depth limit; accepts an untyped value
- members[].assignments[].rubric: polymorphic schema; accepts an untyped value
- members[].classes[].assignmentCategories[]: nested schema exceeds depth limit; accepts an untyped value
- members[].classes[].assignmentDefaults: polymorphic schema; accepts an untyped value
- members[].classes[].assignmentSettings: polymorphic schema; accepts an untyped value
- members[].classes[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- members[].classes[].course: polymorphic schema; accepts an untyped value
- members[].classes[].createdBy: polymorphic schema; accepts an untyped value
- members[].classes[].externalSource: polymorphic schema; accepts an untyped value
- members[].classes[].group: polymorphic schema; accepts an untyped value
- members[].classes[].members[]: recursive schema; accepts an untyped value
- members[].classes[].modules[]: nested schema exceeds depth limit; accepts an untyped value
- members[].classes[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- members[].classes[].teachers[]: recursive schema; accepts an untyped value
- members[].classes[].term: polymorphic schema; accepts an untyped value
- members[].createdBy: polymorphic schema; accepts an untyped value
- members[].externalSource: polymorphic schema; accepts an untyped value
- members[].mailingAddress: polymorphic schema; accepts an untyped value
- members[].onPremisesInfo: polymorphic schema; accepts an untyped value
- members[].passwordProfile: polymorphic schema; accepts an untyped value
- members[].residenceAddress: polymorphic schema; accepts an untyped value
- members[].rubrics[].description: polymorphic schema; accepts an untyped value
- members[].rubrics[].grading: polymorphic schema; accepts an untyped value
- members[].rubrics[].levels[]: nested schema exceeds depth limit; accepts an untyped value
- members[].rubrics[].qualities[]: nested schema exceeds depth limit; accepts an untyped value
- members[].schools[].address: polymorphic schema; accepts an untyped value
- members[].schools[].administrativeUnit: polymorphic schema; accepts an untyped value
- members[].schools[].classes[]: nested schema exceeds depth limit; accepts an untyped value
- members[].schools[].createdBy: polymorphic schema; accepts an untyped value
- members[].schools[].externalSource: polymorphic schema; accepts an untyped value
- members[].schools[].users[]: recursive schema; accepts an untyped value
- members[].student: polymorphic schema; accepts an untyped value
- members[].taughtClasses[].assignmentCategories[]: nested schema exceeds depth limit; accepts an untyped value
- members[].taughtClasses[].assignmentDefaults: polymorphic schema; accepts an untyped value
- members[].taughtClasses[].assignmentSettings: polymorphic schema; accepts an untyped value
- members[].taughtClasses[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- members[].taughtClasses[].course: polymorphic schema; accepts an untyped value
- members[].taughtClasses[].createdBy: polymorphic schema; accepts an untyped value
- members[].taughtClasses[].externalSource: polymorphic schema; accepts an untyped value
- members[].taughtClasses[].group: polymorphic schema; accepts an untyped value
- members[].taughtClasses[].members[]: recursive schema; accepts an untyped value
- members[].taughtClasses[].modules[]: nested schema exceeds depth limit; accepts an untyped value
- members[].taughtClasses[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- members[].taughtClasses[].teachers[]: recursive schema; accepts an untyped value
- members[].taughtClasses[].term: polymorphic schema; accepts an untyped value
- members[].teacher: polymorphic schema; accepts an untyped value
- members[].user: polymorphic schema; accepts an untyped value
- modules[].resources[].resource: polymorphic schema; accepts an untyped value
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
- teachers[].assignments[].addToCalendarAction: polymorphic schema; accepts an untyped value
- teachers[].assignments[].addedStudentAction: polymorphic schema; accepts an untyped value
- teachers[].assignments[].assignTo: polymorphic schema; accepts an untyped value
- teachers[].assignments[].grading: polymorphic schema; accepts an untyped value
- teachers[].assignments[].gradingCategory: polymorphic schema; accepts an untyped value
- teachers[].assignments[].gradingScheme: polymorphic schema; accepts an untyped value
- teachers[].assignments[].instructions: polymorphic schema; accepts an untyped value
- teachers[].assignments[].resources[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].assignments[].rubric: polymorphic schema; accepts an untyped value
- teachers[].classes[].assignmentCategories[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].classes[].assignmentDefaults: polymorphic schema; accepts an untyped value
- teachers[].classes[].assignmentSettings: polymorphic schema; accepts an untyped value
- teachers[].classes[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].classes[].course: polymorphic schema; accepts an untyped value
- teachers[].classes[].createdBy: polymorphic schema; accepts an untyped value
- teachers[].classes[].externalSource: polymorphic schema; accepts an untyped value
- teachers[].classes[].group: polymorphic schema; accepts an untyped value
- teachers[].classes[].members[]: recursive schema; accepts an untyped value
- teachers[].classes[].modules[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].classes[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].classes[].teachers[]: recursive schema; accepts an untyped value
- teachers[].classes[].term: polymorphic schema; accepts an untyped value
- teachers[].createdBy: polymorphic schema; accepts an untyped value
- teachers[].externalSource: polymorphic schema; accepts an untyped value
- teachers[].mailingAddress: polymorphic schema; accepts an untyped value
- teachers[].onPremisesInfo: polymorphic schema; accepts an untyped value
- teachers[].passwordProfile: polymorphic schema; accepts an untyped value
- teachers[].residenceAddress: polymorphic schema; accepts an untyped value
- teachers[].rubrics[].description: polymorphic schema; accepts an untyped value
- teachers[].rubrics[].grading: polymorphic schema; accepts an untyped value
- teachers[].rubrics[].levels[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].rubrics[].qualities[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].schools[].address: polymorphic schema; accepts an untyped value
- teachers[].schools[].administrativeUnit: polymorphic schema; accepts an untyped value
- teachers[].schools[].classes[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].schools[].createdBy: polymorphic schema; accepts an untyped value
- teachers[].schools[].externalSource: polymorphic schema; accepts an untyped value
- teachers[].schools[].users[]: recursive schema; accepts an untyped value
- teachers[].student: polymorphic schema; accepts an untyped value
- teachers[].taughtClasses[].assignmentCategories[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].taughtClasses[].assignmentDefaults: polymorphic schema; accepts an untyped value
- teachers[].taughtClasses[].assignmentSettings: polymorphic schema; accepts an untyped value
- teachers[].taughtClasses[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].taughtClasses[].course: polymorphic schema; accepts an untyped value
- teachers[].taughtClasses[].createdBy: polymorphic schema; accepts an untyped value
- teachers[].taughtClasses[].externalSource: polymorphic schema; accepts an untyped value
- teachers[].taughtClasses[].group: polymorphic schema; accepts an untyped value
- teachers[].taughtClasses[].members[]: recursive schema; accepts an untyped value
- teachers[].taughtClasses[].modules[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].taughtClasses[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].taughtClasses[].teachers[]: recursive schema; accepts an untyped value
- teachers[].taughtClasses[].term: polymorphic schema; accepts an untyped value
- teachers[].teacher: polymorphic schema; accepts an untyped value
- teachers[].user: polymorphic schema; accepts an untyped value
- term: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
