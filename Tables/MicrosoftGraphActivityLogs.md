# Microsoft Graph Activity Logs

<style>
/* Define styles for the spans to simulate cell background */
span.g, span.r, span.y { display: block; padding: 5px; margin: -5px; }
span.g { color: #000000; background-color: #C5FFC4; } /* Green - Available */
span.r { color: #000000; background-color: #FFB8B1; } /* Red - Not available */
span.y { color: #000000; background-color: #EBFFC4; } /* Yellow - Empty value */
</style>

| | [MicrosoftGraphActivityLogs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/microsoftgraphactivitylogs)<br>(Entra Diagnostic) | [GraphAPIAuditEvents](https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-graphapiauditevents-table)<br>(XDR Advanced Hunting) |
| :--- | :--- | :--- |
| **General** | | |
| Billable | Yes | No |
| Retention | 90 days (default) up to 2 years | 30 days (fixed) |
| **Authorization** (from token claim) | | |
| Roles | <span class="g">Yes</span> | <span class="r">No</span> |
| Scopes | <span class="g">Yes</span> | <span class="g">Yes</span> |
| Wids (Directory Roles) | <span class="g">Yes</span> | <span class="r">No</span> |
| **Authentication details** | | |
| ClientAuthMethod (Credential Type) | <span class="g">Yes</span> | <span class="r">No</span> |
| SessionId | <span class="g">Yes</span> | <span class="r">No</span> |
| SignInActivityId (UniqueTokenId) | <span class="g">Yes</span> | <span class="g">Yes</span> |
| TokenIssuedAt | <span class="g">Yes</span> | <span class="r">No</span> |
| **Caller details** | | |
| DeviceId | <span class="g">Yes</span> | <span class="r">No</span> |
| IP Address | <span class="g">Yes</span> | <span class="g">Yes</span> |
| Location | <span class="g">Yes</span> | <span class="g">Yes</span> |
| UserAgent | <span class="g">Yes</span> | <span class="r">No</span> |
| **Graph Activity** | | |
| API Version | <span class="g">Yes</span> | <span class="g">Yes</span> |
| ApplicationId | <span class="g">Yes</span> | <span class="g">Yes</span> |
| ClientRequestId | <span class="g">Yes</span> | <span class="g">Yes</span> |
| OperationId | <span class="g">Yes</span> | <span class="g">Yes</span> |
| RequestMethod | <span class="g">Yes</span> | <span class="g">Yes</span> |
| RequestUri | <span class="g">Yes</span> | <span class="g">Yes</span> |
| DurationMs (RequestDuration) | <span class="g">Yes</span> | <span class="g">Yes</span> |
| ResponseStatusCode | <span class="g">Yes</span> | <span class="g">Yes</span> |
| ResponseSizeBytes | <span class="g">Yes</span> | <span class="r">No</span> |
| | | |
<br/>
| **color legend**  | | | 
| | <span class="g">Available</span> | | 
| | <span class="y">Exists in schema but empty value</span> | | 
| | <span class="r">Not available</span> | | 