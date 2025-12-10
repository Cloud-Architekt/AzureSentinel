# Microsoft Graph Activity Logs

| | [MicrosoftGraphActivityLogs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/microsoftgraphactivitylogs)<br>(Entra Diagnostic) | [GraphAPIAuditEvents](https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-graphapiauditevents-table)<br>(XDR Advanced Hunting) |
| :--- | :--- | :--- |
| **General** | | |
| Billable | Yes | No |
| Retention | 90 days (default) up to 2 years | 30 days (fixed) |
| **Authorization** (from token claim) | | |
| Roles | ✅ Yes | ❌ No |
| Scopes | ✅ Yes | ✅ Yes |
| Wids (Directory Roles) | ✅ Yes | ❌ No |
| **Authentication details** | | |
| ClientAuthMethod (Credential Type) | ✅ Yes | ❌ No |
| SessionId | ✅ Yes | ❌ No |
| SignInActivityId (UniqueTokenId) | ✅ Yes | ✅ Yes |
| TokenIssuedAt | ✅ Yes | ❌ No |
| **Caller details** | | |
| DeviceId | ✅ Yes | ❌ No |
| IP Address | ✅ Yes | ✅ Yes |
| Location | ✅ Yes | ✅ Yes |
| UserAgent | ✅ Yes | ❌ No |
| **Graph Activity** | | |
| API Version | ✅ Yes | ✅ Yes |
| ApplicationId | ✅ Yes | ✅ Yes |
| ClientRequestId | ✅ Yes | ✅ Yes |
| OperationId | ✅ Yes | ✅ Yes |
| RequestMethod | ✅ Yes | ✅ Yes |
| RequestUri | ✅ Yes | ✅ Yes |
| DurationMs (RequestDuration) | ✅ Yes | ✅ Yes |
| ResponseStatusCode | ✅ Yes | ✅ Yes |
| ResponseSizeBytes | ✅ Yes | ❌ No |
| | | |
| **color legend**  | | | 
| | ✅ Available | | 
| | ⚠️ Present in the schema, but the value is empty | | 
| | ❌ Not available | | 
