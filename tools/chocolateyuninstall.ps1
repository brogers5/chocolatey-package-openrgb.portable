$ErrorActionPreference = 'Stop'

$unzipLocation = Join-Path -Path (Get-ToolsLocation) -ChildPath $env:ChocolateyPackageName
Remove-Item -Path $unzipLocation -Recurse -Force -ErrorAction SilentlyContinue

$linkName = 'OpenRGB.lnk'

$programsDirectory = [Environment]::GetFolderPath([Environment+SpecialFolder]::Programs)
$programsShortcutFilePath = Join-Path -Path $programsDirectory -ChildPath $linkName
if (Test-Path $programsShortcutFilePath) {
  Remove-Item $programsShortcutFilePath
}

$desktopDirectory = [Environment]::GetFolderPath([Environment+SpecialFolder]::DesktopDirectory)
$desktopShortcutFilePath = Join-Path -Path $desktopDirectory -ChildPath $linkName
if (Test-Path $desktopShortcutFilePath) {
  Remove-Item $desktopShortcutFilePath
}

#The Remove-Service cmdlet only exists for PowerShell Core. Using sc.exe to ensure compatibility with Windows PowerShell.
$scPath = Join-Path -Path $env:SystemRoot -ChildPath 'System32' | Join-Path -ChildPath 'sc.exe'
Start-ChocolateyProcessAsAdmin -ExeToRun $scPath -Statements @('delete', "$env:ChocolateyPackageName") -Elevated -ValidExitCodes @(0, #ERROR_SUCCESS
  1060, #ERROR_SERVICE_DOES_NOT_EXIST
  1072) #ERROR_SERVICE_MARKED_FOR_DELETE

Uninstall-BinFile -Name 'OpenRGB'
