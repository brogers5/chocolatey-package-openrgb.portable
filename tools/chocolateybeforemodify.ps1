$ErrorActionPreference = 'Stop'

$processName = 'OpenRGB'

try {
    $service = Get-Service -Name $env:ChocolateyPackageName -ErrorAction SilentlyContinue
    if ($service) {
        if ($service.Status -eq 'Running') {
            Write-Warning "$processName service is currently running, stopping it to prevent upgrade/uninstall from failing..."
            Stop-Service -InputObject $service -Force
        }
    }
}
catch {
    Write-Debug "$processName service was not found"
}

$process = Get-Process -Name $processName -ErrorAction SilentlyContinue

if ($process) {
    Write-Warning "$processName is currently running, stopping it to prevent upgrade/uninstall from failing..."
    Stop-Process -InputObject $process -ErrorAction SilentlyContinue

    Start-Sleep -Seconds 3

    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($process) {
        Write-Warning "$processName is still running despite stop request, force stopping it..."
        Stop-Process -InputObject $process -Force -ErrorAction SilentlyContinue
    }

    Write-Warning "If upgrading, $processName may need to be manually restarted upon completion"
}
else {
    Write-Debug "No running $processName process instances were found"
}
