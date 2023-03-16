$session = New-Object -ComObject Microsoft.Update.Session
$searcher = $session.CreateUpdateSearcher()
$historyCount = $searcher.GetTotalHistoryCount()
$updateHistory = $searcher.QueryHistory(0, $historyCount)

$updateInProgress = $false

foreach ($update in $updateHistory) {
    if ($update.IsDownloading) {
        $updateInProgress = $true
        Write-Host "Windows Update is currently downloading updates."
        break
    } elseif ($update.IsInstalled -ne 'True') {
        $updateInProgress = $true
        Write-Host "Windows Update is currently installing updates."
        break
    }
}

if (!$updateInProgress) {
    Write-Host "Windows Update is not currently updating."
}
