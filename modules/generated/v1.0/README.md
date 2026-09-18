# Microsoft Graph v1.0 module catalog

**1431 generated modules**, organized by the [Microsoft Graph API reference](https://github.com/microsoftgraph/microsoft-graph-docs-contrib/blob/4ad99fd37a9e2e8538275a0a9cdff7907052f3ec/api-reference/v1.0/toc.yml).

Only collections with documented POST and item GET, PATCH/PUT, and DELETE operations are generated. Counts describe this supported CRUD subset; they do not imply coverage of every API in a category. Categories with no generated module are retained for browsing.

## Folder hierarchy

Category folders are shown below; use the category links for the complete endpoint list.

```text
v1.0/
├── README.md
├── manifest.json
├── users/  # 25 modules
├── groups/  # 5 modules
├── applications/  # 23 modules
├── agents/  # 0 modules
├── backup-and-recovery/  # 31 modules
├── calendars/  # 28 modules
├── change-notifications/  # 6 modules
├── compliance/  # 3 modules
├── cross-device-experiences/  # 10 modules
├── customer-booking/  # 7 modules
├── device-and-app-management/  # 160 modules
├── education/  # 41 modules
├── employee-experience/  # 5 modules
├── extensions/  # 39 modules
├── external-data-connections/  # 12 modules
├── files/  # 23 modules
├── identity-and-access/  # 322 modules
├── mail/  # 25 modules
├── mailbox-import-and-export/  # 1 module
├── notes/  # 70 modules
├── people-and-workplace-intelligence/  # 16 modules
├── personal-contacts/  # 10 modules
├── reports/  # 5 modules
├── partner-billing-reports/  # 2 modules
├── search/  # 3 modules
├── security/  # 72 modules
├── sites-and-lists/  # 190 modules
├── tasks-and-plans/  # 19 modules
├── teamwork-and-communications/  # 251 modules
├── tenants/  # 2 modules
├── to-do-tasks/  # 8 modules
├── workbooks-and-charts/  # 16 modules
└── other/  # 1 module
```

Each category contains a README index. Zero-count categories contain an index only.

Endpoint folders follow the Graph route beneath their category. `by-<parameter>` marks a parent-ID parameter; complex routes can use a stable `by-path-<hash>` segment. The module README and manifest retain the exact Graph URL.

Example: [applications/applications/by-application-id/extension-properties](applications/applications/by-application-id/extension-properties/README.md). This is one module from this catalog:

```text
v1.0/
└── applications/
    └── applications/
        └── by-application-id/
            └── extension-properties/
                ├── README.md
                ├── main.tf
                ├── variables.tf
                ├── outputs.tf
                ├── versions.tf
                └── tests/
                    └── module.tftest.hcl
```

## Browse categories

| Category | Modules | Microsoft reference |
| --- | ---: | --- |
| [Users](users/README.md) | 25 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/users?view=graph-rest-1.0&preserve-view=true) |
| [Groups](groups/README.md) | 5 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/groups-overview?view=graph-rest-1.0&preserve-view=true) |
| [Applications](applications/README.md) | 23 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/applications-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Agents](agents/README.md) | 0 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/agentid-platform-overview?view=graph-rest-1.0&preserve-view=true) |
| [Backup and recovery](backup-and-recovery/README.md) | 31 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tenants-backup-recovery-overview?view=graph-rest-1.0&preserve-view=true) |
| [Calendars](calendars/README.md) | 28 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendar-overview?view=graph-rest-1.0&preserve-view=true) |
| [Change notifications](change-notifications/README.md) | 6 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/change-notifications-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Compliance](compliance/README.md) | 3 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/complianceapioverview?view=graph-rest-1.0&preserve-view=true) |
| [Cross-device experiences](cross-device-experiences/README.md) | 10 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/project-rome-overview?view=graph-rest-1.0&preserve-view=true) |
| [Customer booking](customer-booking/README.md) | 7 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/booking-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Device and app management](device-and-app-management/README.md) | 160 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [Education](education/README.md) | 41 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/education-overview?view=graph-rest-1.0&preserve-view=true) |
| [Employee experience](employee-experience/README.md) | 5 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [Extensions](extensions/README.md) | 39 | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [External data connections](external-data-connections/README.md) | 12 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/connectors-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Files](files/README.md) | 23 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onedrive?view=graph-rest-1.0&preserve-view=true) |
| [Identity and access](identity-and-access/README.md) | 322 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) |
| [Mail](mail/README.md) | 25 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/mail-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Mailbox import and export](mailbox-import-and-export/README.md) | 1 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/mailbox-import-export-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Notes](notes/README.md) | 70 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onenote-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [People and workplace intelligence](people-and-workplace-intelligence/README.md) | 16 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/social-overview?view=graph-rest-1.0&preserve-view=true) |
| [Personal contacts](personal-contacts/README.md) | 10 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [Reports](reports/README.md) | 5 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [Partner billing reports](partner-billing-reports/README.md) | 2 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/partners-billing-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Search](search/README.md) | 3 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [Security](security/README.md) | 72 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Sites and lists](sites-and-lists/README.md) | 190 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/sharepoint?view=graph-rest-1.0&preserve-view=true) |
| [Tasks and plans](tasks-and-plans/README.md) | 19 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/planner-overview?view=graph-rest-1.0&preserve-view=true) |
| [Teamwork and communications](teamwork-and-communications/README.md) | 251 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Tenants](tenants/README.md) | 2 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tenants-overview?view=graph-rest-1.0&preserve-view=true) |
| [To-do tasks](to-do-tasks/README.md) | 8 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/todo-overview?view=graph-rest-1.0&preserve-view=true) |
| [Workbooks and charts](workbooks-and-charts/README.md) | 16 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/excel?view=graph-rest-1.0&preserve-view=true) |
| [Uncategorized](other/README.md) | 1 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |

Each endpoint has one physical module. Resource types and service routes resolve documentation cross-listings; parent paths such as `/users` do not turn mail or calendar modules into user modules. Uncategorized is a generator fallback, not an official Microsoft category.

Open a category, then an endpoint README for inputs, permissions guidance, import notes, and credential-free tests. Exact Graph URLs remain in every module and in [manifest.json](manifest.json).
