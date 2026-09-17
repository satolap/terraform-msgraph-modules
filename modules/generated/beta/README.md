# Microsoft Graph beta module catalog

**2480 generated modules**, organized by the [Microsoft Graph API reference](https://github.com/microsoftgraph/microsoft-graph-docs-contrib/blob/4ad99fd37a9e2e8538275a0a9cdff7907052f3ec/api-reference/beta/toc.yml).

Only collections with documented POST and item GET, PATCH/PUT, and DELETE operations are generated. Counts describe this supported CRUD subset; they do not imply coverage of every API in a category. Categories with no generated module are retained for browsing.

## Folder hierarchy

Category folders are shown below; use the category links for the complete endpoint list.

```text
beta/
├── README.md
├── manifest.json
├── users/  # 23 modules
├── groups/  # 6 modules
├── applications/  # 31 modules
├── agents/  # 4 modules
├── backup-and-recovery/  # 40 modules
├── calendars/  # 32 modules
├── change-notifications/  # 6 modules
├── compliance/  # 29 modules
├── cross-device-experiences/  # 10 modules
├── customer-booking/  # 14 modules
├── device-and-app-management/  # 474 modules
├── education/  # 41 modules
├── employee-experience/  # 10 modules
├── extensions/  # 44 modules
├── external-data-connections/  # 13 modules
├── files/  # 25 modules
├── financials-preview/  # 41 modules
├── identity-and-access/  # 555 modules
├── industry-data-etl-preview/  # 8 modules
├── mail/  # 21 modules
├── mailbox-import-and-export/  # 3 modules
├── notes/  # 70 modules
├── notifications-deprecated/  # 2 modules
├── people-and-workplace-intelligence/  # 80 modules
├── personal-contacts/  # 12 modules
├── reports/  # 30 modules
├── search/  # 3 modules
├── security/  # 137 modules
├── sites-and-lists/  # 184 modules
├── tasks-and-plans/  # 107 modules
├── teamwork-and-communications/  # 332 modules
├── tenants/  # 29 modules
├── to-do-tasks/  # 20 modules
├── workbooks-and-charts/  # 26 modules
└── other/  # 18 modules
```

Each category contains a README index. Zero-count categories contain an index only.

Endpoint folders follow the Graph route beneath their category. `by-<parameter>` marks a parent-ID parameter; complex routes can use a stable `by-path-<hash>` segment. The module README and manifest retain the exact Graph URL.

Example: [applications/applications/by-application-id/federated-identity-credentials](applications/applications/by-application-id/federated-identity-credentials/README.md). This is one module from this catalog:

```text
beta/
└── applications/
    └── applications/
        └── by-application-id/
            └── federated-identity-credentials/
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
| [Users](users/README.md) | 23 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/users?view=graph-rest-beta&preserve-view=true) |
| [Groups](groups/README.md) | 6 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/groups-overview?view=graph-rest-beta&preserve-view=true) |
| [Applications](applications/README.md) | 31 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/applications-api-overview?view=graph-rest-beta&preserve-view=true) |
| [Agents](agents/README.md) | 4 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/agentid-platform-overview?view=graph-rest-beta&preserve-view=true) |
| [Backup and recovery](backup-and-recovery/README.md) | 40 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tenants-backup-recovery-overview?view=graph-rest-beta&preserve-view=true) |
| [Calendars](calendars/README.md) | 32 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendar-overview?view=graph-rest-beta&preserve-view=true) |
| [Change notifications](change-notifications/README.md) | 6 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/change-notifications-api-overview?view=graph-rest-beta&preserve-view=true) |
| [Compliance](compliance/README.md) | 29 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/complianceapioverview?view=graph-rest-beta&preserve-view=true) |
| [Cross-device experiences](cross-device-experiences/README.md) | 10 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/project-rome-overview?view=graph-rest-beta&preserve-view=true) |
| [Customer booking](customer-booking/README.md) | 14 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/booking-api-overview?view=graph-rest-beta&preserve-view=true) |
| [Device and app management](device-and-app-management/README.md) | 474 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true) |
| [Education](education/README.md) | 41 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/education-overview?view=graph-rest-beta&preserve-view=true) |
| [Employee experience](employee-experience/README.md) | 10 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true) |
| [Extensions](extensions/README.md) | 44 | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-beta&preserve-view=true) |
| [External data connections](external-data-connections/README.md) | 13 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/connectors-api-overview?view=graph-rest-beta&preserve-view=true) |
| [Files](files/README.md) | 25 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onedrive?view=graph-rest-beta&preserve-view=true) |
| [Financials (preview)](financials-preview/README.md) | 41 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/dynamics-graph-reference?view=graph-rest-beta&preserve-view=true) |
| [Identity and access](identity-and-access/README.md) | 555 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-beta&preserve-view=true) |
| [Industry data ETL (preview)](industry-data-etl-preview/README.md) | 8 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/industrydata-overview?view=graph-rest-beta&preserve-view=true) |
| [Mail](mail/README.md) | 21 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/mail-api-overview?view=graph-rest-beta&preserve-view=true) |
| [Mailbox import and export](mailbox-import-and-export/README.md) | 3 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/mailbox-import-export-api-overview?view=graph-rest-beta&preserve-view=true) |
| [Notes](notes/README.md) | 70 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onenote-api-overview?view=graph-rest-beta&preserve-view=true) |
| [Notifications (deprecated)](notifications-deprecated/README.md) | 2 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/notifications-api-overview?view=graph-rest-beta&preserve-view=true) |
| [People and workplace intelligence](people-and-workplace-intelligence/README.md) | 80 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/social-overview?view=graph-rest-beta&preserve-view=true) |
| [Personal contacts](personal-contacts/README.md) | 12 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true) |
| [Reports](reports/README.md) | 30 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true) |
| [Search](search/README.md) | 3 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true) |
| [Security](security/README.md) | 137 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-beta&preserve-view=true) |
| [Sites and lists](sites-and-lists/README.md) | 184 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/sharepoint?view=graph-rest-beta&preserve-view=true) |
| [Tasks and plans](tasks-and-plans/README.md) | 107 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/planner-overview?view=graph-rest-beta&preserve-view=true) |
| [Teamwork and communications](teamwork-and-communications/README.md) | 332 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-beta&preserve-view=true) |
| [Tenants](tenants/README.md) | 29 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tenants-overview?view=graph-rest-beta&preserve-view=true) |
| [To-do tasks](to-do-tasks/README.md) | 20 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/todo-overview?view=graph-rest-beta&preserve-view=true) |
| [Workbooks and charts](workbooks-and-charts/README.md) | 26 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/excel?view=graph-rest-beta&preserve-view=true) |
| [Uncategorized](other/README.md) | 18 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-beta&preserve-view=true) |

Each endpoint has one physical module. Resource types and service routes resolve documentation cross-listings; parent paths such as `/users` do not turn mail or calendar modules into user modules. Uncategorized is a generator fallback, not an official Microsoft category.

Open a category, then an endpoint README for inputs, permissions guidance, import notes, and credential-free tests. Exact Graph URLs remain in every module and in [manifest.json](manifest.json).
