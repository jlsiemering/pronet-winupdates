#Set group policy objects for windows update for business. This requires installation of PolicyFileEditor from The PS Gallery

#install PolicyFileEditor
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Write-Host "NuGet has been installed"
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Install-Module -Name PolicyFileEditor -RequiredVersion 3.0.0 -Force
Import-Module -Name PolicyFileEditor
Write-Host "PolicyFileEditor has been installed"

#defer feature updates
Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "Software\Policies\Microsoft\Windows\WindowsUpdate" -ValueName DeferFeatureUpdates -Data 1 -Type DWORD
#set when feature updates are received (default deferrment is 90 days)
Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "Software\Policies\Microsoft\Windows\WindowsUpdate" -ValueName DeferFeatureUpdatesPeriodInDays -Data 90 -Type DWORD
#defer quality updates
Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "Software\Policies\Microsoft\Windows\WindowsUpdate" -ValueName DeferQualityUpdates -Data 1 -Type DWORD
#set when quality updates are installed (default deferrment is 14 days)
Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "Software\Policies\Microsoft\Windows\WindowsUpdate" -ValueName DeferQualityUpdatesPeriodInDays -Data 14 -Type DWORD
#make sure wufb safeguards are on
Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "Software\Policies\Microsoft\Windows\WindowsUpdate" -ValueName DisableWUfBSafeguards -Data 0 -Type DWORD
#disable preview builds     
Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "Software\Policies\Microsoft\Windows\WindowsUpdate" -ValueName ManagePreviewBuilds -Data 1 -Type DWORD
#disable preview builds
Set-PolicyFileEntry -Path $env:systemroot\system32\GroupPolicy\Machine\registry.pol -Key "Software\Policies\Microsoft\Windows\WindowsUpdate" -ValueName ManagePreviewBuildsPolicyValue -Data 0 -Type DWORD

#apply the policy to the host immediately
gpupdate.exe /force

Write-Host "The script has run successfully. Check the WUfB policy objects to verify they have been changed."