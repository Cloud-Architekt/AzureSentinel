<#
.SYNOPSIS
Ingests Maester test results from a specified folder into a Log Analytics Custom Log Table using Azure Data Collection Rules.

.DESCRIPTION
This script reads test results from JSON files in a specified folder, processes the data, and ingests it into a Log Analytics Custom Log Table.
It uses Azure Data Collection Rules to direct the data to the appropriate Log Analytics workspace.
The script requires the AzAPICall module to be installed and configured with appropriate permissions to access Azure resources.
It's designed to be used in a CI/CD pipeline, such as GitHub Actions, to automate the ingestion of test results.

.PARAMETER ImportFolder
The folder containing the test results in JSON format. Default is "tests.results".

.PARAMETER TempFolder
The temporary folder where intermediate files will be stored. Default is "temp".

.PARAMETER DataCollectionRuleSubscriptionId
The subscription ID where the Data Collection Rule is located. This is required for the script to function.

.PARAMETER DataCollectionRuleResourceGroup
The resource group containing the Data Collection Rule. Default is "maester-rg".

.PARAMETER DataCollectionRuleName
The name of the Data Collection Rule to use for ingestion. Default is "maester-dcr".

.PARAMETER LogAnalyticsCustomLogTableName
The name of the Log Analytics Custom Log Table where the data will be ingested. Default is "Maester_CL".

.PARAMETER ThrottleLimitMonitor
The maximum number of parallel requests to the Azure Monitor ingestion endpoint. Default is 5.

.EXAMPLE
Run interactively in PowerShell to ingest test results:
.\ingest.ps1 -ImportFolder "path\to\results" -DataCollectionRuleSubscriptionId "your-subscription-id"

.EXAMPLE
Copy this line into the next step in a GitHub Actions workflow after Maester collects data to automate the ingestion of test results:
- name: Ingest Maester results
  uses: azure/powershell@v2
  with:
    inlineScript: |
      .\ingest.ps1 `
        -ImportFolder "test-results" `
        -DataCollectionRuleSubscriptionId "${{ secrets.AZURE_SUBSCRIPTION_ID }}" `
        -DataCollectionRuleResourceGroup "maester-rg" `
        -DataCollectionRuleName "maester-dcr" `
        -LogAnalyticsCustomLogTableName "Maester_CL"
    azPSVersion: "latest"

#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$ImportFolder = "tests.results",

    [Parameter(Mandatory = $false)]
    [string]$TempFolder = "temp",

    [Parameter(Mandatory = $true)]
    [string]$DataCollectionRuleSubscriptionId,

    [Parameter(Mandatory = $false)]
    [string]$DataCollectionRuleResourceGroup = "maester-rg",

    [Parameter(Mandatory = $false)]
    [string]$DataCollectionRuleName = "maester-dcr",

    [Parameter(Mandatory = $false)]
    [string]$LogAnalyticsCustomLogTableName = "Maester_CL",

    [Parameter(Mandatory = $false)]
    [int]$ThrottleLimitMonitor = 5
)

Install-Module AzAPICall -Force
New-Item -Path $TempFolder -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null

Write-Host "Ingesting to Log Analytics Custom Log Table '$($LogAnalyticsCustomLogTableName)'"
Write-Host " DataCollectionRuleSubscriptionId '$($DataCollectionRuleSubscriptionId)'"
Write-Host " DataCollectionRuleResourceGroup '$($DataCollectionRuleResourceGroup)'"
Write-Host " DataCollectionRuleName: '$($DataCollectionRuleName)'"
Write-Host " LogAnalyticsCustomLogTableName: '$($LogAnalyticsCustomLogTableName)'"
Write-Host " ThrottleLimitMonitor: '$($ThrottleLimitMonitor)'"

$TestResultsJsonFile = (Get-ChildItem -Path $ImportFolder -Recurse -Filter "*.json" | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1).FullName
Write-Warning $TestResultsJsonFile

$TestResultsJSON = Get-Content -Path $TestResultsJsonFile | ConvertFrom-Json -Depth 10 
$TestResultsCleanJSON = $TestResultsJSON.tests | Select-Object -ExcludeProperty ErrorRecord, ScriptBlock, ScriptBlockFile, Duration
foreach ($TestResult in $TestResultsCleanJSON) { 

    $TestResultDetail = ($TestResult.ResultDetail.TestResult | ConvertFrom-Markdown).html

    $TableIndex = -1 #get all tables
    
    $xml = [xml]("<root>$Html</root>")
    $tables = $xml.SelectNodes('//table')
    if (-not $tables) { return }

    if ($TableIndex -ge 0) {
        if ($TableIndex -ge $tables.Count) {
            throw "TableIndex $TableIndex out of range (found $($tables.Count) table[s])."
        }
        $tables = , $tables[$TableIndex]
    }

    $tblNum = 0
    foreach ($table in $tables) {
        $headerNodes = $table.SelectNodes('./thead/tr/th')
        if (-not $headerNodes) {
            # no thead -> treat first row as header and remove it from data
            $first = $table.SelectSingleNode('./tr[1] | ./tbody/tr[1]')
            if ($first) {
                $headerNodes = $first.SelectNodes('./th|./td')
                $first.ParentNode.RemoveChild($first) | Out-Null
            }
        }

        $headers = for ($i = 0; $i -lt $headerNodes.Count; $i++) {
            $name = $headerNodes[$i].InnerText.Trim()
            if (-not $name) { $name = "Column$($i+1)" }
            $name = $name -replace '\s+', '' -replace '[^A-Za-z0-9_]', ''
            $orig = $name; $dup = 1
            while ($_ = $headers | Where-Object { $_ -eq $name }) {
                $dup++; $name = "${orig}_$dup"
            }
            $name
        }

        $rows = $table.SelectNodes('./tbody/tr')
        if (-not $rows) { $rows = $table.SelectNodes('./tr') }

        foreach ($row in $rows) {
            $o = [ordered]@{ }
            $cells = $row.SelectNodes('./td|./th')

            for ($c = 0; $c -lt $cells.Count; $c++) {
                $prop = if ($c -lt $headers.Count) { $headers[$c] } else { "Column$($c+1)" }
                $cell = $cells[$c]
                $raw = $cell.InnerText.Trim()

                #  hyperlinks
                $a = $cell.SelectSingleNode('./a')
                if ($a) {
                    $o["${prop}Text"] = $a.InnerText.Trim()
                    $o["${prop}Link"] = $a.href
                    $raw = $a.InnerText.Trim()
                }
                # stupid icons
                if ($raw -match '^(✓|✔|☑|✅)$' -or $raw -eq 'True') { $val = $true }
                elseif ($raw -match '^(✗|×|❌)$' -or $raw -eq 'False') { $val = $false }
                else {
                    $dt = [datetime]::MinValue
                    if ([datetime]::TryParse($raw, [ref]$dt)) { $val = $dt }
                    else { $val = $raw }
                }
                $o[$prop] = $val
            }
            $tableObject = [pscustomobject]$o
        }
        $tblNum++
    }

     $TestResult.ResultDetail | Add-Member -MemberType NoteProperty -Name 'TestResultTable' -Value $tableObject -Force

    Write-Host $($TestResult.Id)
    $TestResult | ConvertTo-Json -Depth 10 | Out-File -FilePath "./temp/$($TestResult.Index).json" -Encoding utf8
}


# Get Maester JSON files
$MaesterJsonFiles = (Get-ChildItem -Path $TempFolder -Recurse -Filter '*.json').FullName
$MaesterJsonFilesCount = $MaesterJsonFiles.Count
Write-Host "Found $($MaesterJsonFilesCount) JSON files in directory '$($TempFolder)'"

if ($MaesterJsonFilesCount -eq 0) {
    Write-Host 'Nothing to do!?'
} else {
    $azAPICallConf = initAzAPICall

    $UTC = (Get-Date).ToUniversalTime()
    $logTimeGenerated = $UTC.ToString('o')
    $runId = $UTC.ToString('yyyyMMddHHmmss')
    Write-Host "RunId: $($runId)"

    $currentTask = "Get Data Collection Rule $($DataCollectionRuleName)"
    $uriDCR = "$($azAPICallConf['azAPIEndpointUrls'].ARM)/subscriptions/$($DataCollectionRuleSubscriptionId)/resourceGroups/$($DataCollectionRuleResourceGroup)/providers/Microsoft.Insights/dataCollectionRules/$($DataCollectionRuleName)?api-version=2022-06-01"
    $DCR = AzAPICall -AzAPICallConfiguration $azAPICallConf -uri $uriDCR -method 'Get' -listenOn Content -currentTask $currentTask

    $dataCollectionEndpointId = $DCR.properties.dataCollectionEndpointId
    $currentTask = "Get Data Collection Endpoint $($dataCollectionEndpointId)"
    $uriDCE = "$($azAPICallConf['azAPIEndpointUrls'].ARM)$($dataCollectionEndpointId)?api-version=2022-06-01"
    $dceResourceJson = AzAPICall -AzAPICallConfiguration $azAPICallConf -uri $uriDCE -method 'Get' -listenOn Content -currentTask $currentTask
    $dceIngestEndpointUrl = $dceResourceJson.properties.logsIngestion.endpoint

    $postUri = "$dceIngestEndpointUrl/dataCollectionRules/$($DCR.properties.immutableId)/streams/Custom-$($LogAnalyticsCustomLogTableName)?api-version=2023-01-01"

    createBearerToken -targetEndPoint 'MonitorIngest' -AzAPICallConfiguration $azAPICallConf

    $batchSize = [math]::ceiling($MaesterJsonFilesCount / $ThrottleLimitMonitor)
    Write-Host "Optimal batch size: $($batchSize)"
    $counterBatch = [PSCustomObject] @{ Value = 0 }
    $filesBatch = ($MaesterJsonFiles) | Group-Object -Property { [math]::Floor($counterBatch.Value++ / $batchSize) }
    Write-Host "Ingesting data in $($filesBatch.Count) batches"

    $filesBatch | ForEach-Object -Parallel {
        $logTimeGenerated = $using:logTimeGenerated
        $runId = $using:runId
        $postUri = $using:postUri
        $azAPICallConf = $using:azAPICallConf

        $filesProcessCounter = 0
        foreach ($jsonFilePath in $_.Group) {
            $filesProcessCounter++
            $jsonRaw = Get-Content -Path $jsonFilePath -Raw
            try {
                $jsonObject = $jsonRaw | ConvertFrom-Json
                $checkInfoObj = [ordered]@{
                    CheckType = $jsonObject.Block
                    CheckId = $jsonObject.Id
                }
                $checkInfoObj = ($checkInfoObj.Keys | ForEach-Object { "$($_)=$($checkInfoObj.($_))" }) -join ', '
                # Add TimeGenerated to JSON data
                $jsonObject | Add-Member -NotePropertyName TimeGenerated -NotePropertyValue $logTimeGenerated -Force
                $jsonObject | Add-Member -NotePropertyName RunId -NotePropertyValue $runId -Force
                $jsonRawAsArray = $jsonObject | ConvertTo-Json -AsArray -Compress -Depth 10
            }
            catch {
                Write-Error 'Cannot convert jsonRaw content to jsonObject'
                throw $_
            }

            $currentTask = "Batch#$($_.Name); Process file $($filesProcessCounter)/$($_.Count); Ingesting data for $($checkInfoObj)"
            Write-Host $currentTask
            AzAPICall -AzAPICallConfiguration $azAPICallConf -uri $postUri -method 'Post' -body $jsonRawAsArray -currentTask $currentTask
        }
    } -ThrottleLimit $ThrottleLimitMonitor

    Remove-Item -Path "$TempFolder\*" -Force -Recurse -ErrorAction SilentlyContinue
}
