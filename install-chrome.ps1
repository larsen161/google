# This will run this code below directly in powershell
# $ScriptFromGitHub = Invoke-WebRequest https://raw.githubusercontent.com/larsen161/google/master/install-chrome.ps1 Invoke-Expression $($ScriptFromGitHub.Content)

$Path = $env:TEMP; $Installer = "chrome_installer.exe"; Invoke-WebRequest "http://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait; Remove-Item $Path\$Installer
