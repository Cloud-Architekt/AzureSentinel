# Microsoft Entra User Sign-In Events

| Category | [SigninLogs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/SigninLogs), [AADNonInteractiveUserSignInLogs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/AADNonInteractiveUserSignInLogs)<br>(Entra Diagnostic) | [EntraIdSignInEvents](https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-entraidsigninevents-table)<br>(XDR Advanced Hunting) |
| :--- | :--- | :--- |
| **General** | | |
| Billable | Yes | No |
| Retention | 90 days (default) up to 2 years | 30 days (fixed) |
| **Timestamp** | | |
| | ✅ TimeGenerated | ✅ TimeGenerated |
| | ✅ CreatedDateTime | ✅ Timestamp |
| **Authentication** | | |
| | ✅ AuthenticationAppDeviceDetails | ❌ N/A |
| | ✅ AuthenticationAppPolicyEvaluationDetails | ❌ N/A |
| | ✅ AuthenticationContextClassReferences | ❌ N/A |
| | ✅ AuthenticationDetails | ❌ N/A |
| | ✅ AuthenticationMethodsUsed | ❌ N/A |
| | ✅ AuthenticationProcessingDetails | ✅ AuthenticationProcessingDetails |
| | ✅ AuthenticationProtocol | ❌ N/A |
| | ✅ AuthenticationRequirement | ✅ AuthenticationRequirement |
| | ✅ AuthenticationRequirementPolicies | ❌ N/A |
| | ✅ CrossTenantAccessType | ❌ N/A |
| **Sign-in**| | |
| | ✅ AADTenantId | ❌ N/A |
| | ✅ AppId | ✅ ApplicationId |
| | ✅ AppDisplayName | ✅ Application |
| | ✅ AppOwnerTenantId | ❌ N/A |
| | ❌ N/A | ✅ EndpointCall |
| | ❌ N/A | ✅ GatewayJA4 |
| | ✅ IncomingTokenType | ❌ N/A |
| | ✅ IsInteractive | ✅ LogonType |
| | ✅ MfaDetail | ❌ N/A |
| | ✅ Resource | ❌ N/A |
| | ✅ ResourceDisplayName | ✅ ResourceDisplayName |
| | ✅ ResourceId | ✅ ResourceId |
| | ✅ ResourceIdentity | ❌ N/A |
| | ✅ ResourceOwnerTenantId | ❌ N/A |
| | ✅ ResourceProvider | ❌ N/A |
| | ✅ ResourceServicePrincipalId | ❌ N/A |
| | ✅ ResourceTenantId | ✅ ResourceTenantId |
| | ✅ ResultDescription | ❌ N/A |
| | ✅ ResultSignature | ❌ N/A |
| | ✅ ResultType | ✅ ErrorCode |
| | ✅ Status | ❌ N/A |
| **Sign-in identifiers** | | |
| | ✅ CorrelationId | ✅ CorrelationId |
| | ✅ Id; OriginalRequestId | ✅ RequestId |
| | ✅ SessionId | ✅ SessionId |
| | ✅ SignInIdentifier | ❌ N/A |
| | ✅ SignInIdentifierType | ❌ N/A |
| | ✅ UniqueTokenIdentifier | ❌ N/A |
| **Agent details**| | |
| | ✅ Agent | ❌ N/A |
| **App or Workload Identity Details** | | |
| | ✅ AppliedEventListeners | ❌ N/A |
| | ✅ ClientCredentialType | ❌ N/A |
| | ✅ FederatedCredentialId | ❌ N/A |
| | ✅ ServicePrincipalId | ❌ N/A |
| | ✅ ServicePrincipalName | ❌ N/A |
| **User Details** | | |
| | ✅ AlternateSignInName | ✅ AlternateSignInName |
| | ✅ HomeTenantId | ❌ N/A |
| | ⚠️ HomeTenantName | ❌ N/A |
| | ✅ LastPasswordChangeTimestamp | ❌ N/A |
| | ✅ Identity | ❌ N/A |
| | ✅ UserDisplayName | ✅ AccountDisplayName |
| | ✅ UserId | ✅ AccountObjectId |
| | ✅ UserPrincipalName | ✅ AccountUpn |
| | ✅ UserType | ✅ IsExternalUser |
| | ❌ N/A | ✅ IsGuestUser |
| **Client Details** | | |
| | ✅ ClientAppUsed | ✅ ClientAppUsed |
| | ✅ SourceAppClientId | ❌ N/A |
| | ✅ UserAgent | ✅ UserAgent |
| **Conditional Access** | | |
| | ✅ AppliedConditionalAccessPolicies | ❌ N/A |
| | ✅ ConditionalAccessPolicies | ✅ ConditionalAccessPolicies |
| | ❌ N/A | ⚠️ ConditionalAccessPoliciesV2 |
| | ✅ ConditionalAccessStatus | ✅ ConditionalAccessStatus |
| **Device** | | |
| | ✅ DeviceDetail | ✅ Browser |
| | | ✅ DeviceName |
| | | ✅ DeviceTrustType |
| | | ✅ EntraIdDeviceId |
| | | ✅ IsCompliant |
| | | ✅ IsManaged |
| | | ✅ OSPlatform |
| **Location** | | |
| | ✅ Location | ✅ Country |
| | ✅ LocationDetails | ✅ City |
| | | ✅ Latitude |
| | | ✅ Longitude |
| | | ✅ State |
| **Network** | | |
| | ✅ AutonomousSystemNumber | ❌ N/A |
| | ✅ GlobalSecureAccessIpAddress | ❌ N/A |
| | ✅ IPAddress | ✅ IPAddress |
| | ✅ IPAddressFromResourceProvider | ❌ N/A |
| | ✅ IsThroughGlobalSecureAccess | ❌ N/A |
| | ✅ NetworkLocationDetails | ✅ NetworkLocationDetails |
| **Security and risk details** | | |
| | ✅ FlaggedForReview | ❌ N/A |
| | ✅ IsRisky | ❌ N/A |
| | ✅ IsTenantRestricted | ❌ N/A |
| | ✅ RiskDetail | ❌ N/A |
| | ✅ RiskEventTypes | ✅ RiskEventTypes |
| | ✅ RiskEventTypes_V2 | ❌ N/A |
| | ✅ RiskLevel | ❌ N/A |
| | ✅ RiskLevelAggregated | ✅ RiskLevelAggregated |
| | ✅ RiskLevelDuringSignIn | ✅ RiskLevelDuringSignIn |
| | ✅ RiskState | ✅ RiskState |
| **Token and Session** | | |
| | ✅ IncomingTokenType | ❌ N/A |
| | ✅ SessionLifetimePolicies | ❌ N/A |
| | ✅ OriginalTransferMethod | ❌ N/A |
| | ✅ TokenIssuerName | ❌ N/A |
| | ✅ TokenIssuerType | ✅ TokenIssuerType |
| | ✅ TokenProtectionStatusDetails | ❌ N/A |
| **Logging detail** | | |
| | ✅ Category | ❌ N/A |
| | ⚠️ Level | ❌ N/A |
| | ✅ OperationName | ❌ N/A |
| | ✅ OperationVersion | ❌ N/A |
| | ❌ N/A | ✅ ReportId |
| | ✅ ResourceGroup | ❌ N/A |
| | ✅ SourceSystem | ⚠️ SourceSystem |
| | ✅ TenantId (= WorkspaceId) | ❌ N/A |
| | ✅ Type | ✅ Type |
| **Telemetry** | | |
| | ✅ DurationMs | ❌ N/A |
| | ✅ ProcessingTimeInMilliseconds | ❌ N/A |
| | | |
| **color legend**  | | | 
| | ✅ Available | | 
| | ⚠️ Present in the schema, but the value is empty | | 
| | ❌ Not available | | 
