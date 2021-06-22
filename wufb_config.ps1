#New version of a powershell script that changes the LGPO items for WUFB
#Dependent on LGPO.exe to function

#Downloads LGPO.exe to the kworking directory for usage, unzips it, and renames it
Invoke-WebRequest -Uri 'https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/LGPO.zip' -Outfile C:\kworking\LGPO.zip
Expand-Archive -LiteralPath C:\kworking\LGPO.zip -DestinationPath C:\kworking\
Rename-Item C:\kworking\LGPO_30 C:\kworking\lgporun -Force
if (Test-Path -Path C:\kworking\lgporun)
{Write-Host "Successfully downloaded LGPO.exe"}

#Uses LGPO.exe to make a baseline LGPO backup in the kworking directory
if (Test-Path -Path C:\kworking\LGPO)
{Write-Host "LGPO Folder Already Exists"}
else
{New-Item -Path C:\kworking -Name "LGPO" -ItemType "directory"}
C:\kworking\lgporun\LGPO.exe /parse /m C:\Windows\System32\GroupPolicy\Machine\Registry.pol >> C:\kworking\LGPO\baseline.txt

#Writes the desired LGPO config to a variable and saves it as a text file
$POL = "
; ----------------------------------------------------------------------
; PARSING Computer POLICY
; Source file:  C:\Windows\System32\GroupPolicy\Machine\Registry.pol

Computer
SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
DisableWUfBSafeguards
DWORD:0

Computer
SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
DeferFeatureUpdates
DWORD:1

Computer
SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
DeferFeatureUpdatesPeriodInDays
DWORD:90

Computer
SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
DeferQualityUpdates
DWORD:1

Computer
SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
DeferQualityUpdatesPeriodInDays
DWORD:14

Computer
SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
ManagePreviewBuilds
DWORD:1

Computer
SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
ManagePreviewBuildsPolicyValue
DWORD:0

Computer
SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
BranchReadinessLevel
DWORD:16

; PARSING COMPLETED.
; ----------------------------------------------------------------------

"
Out-File -FilePath C:\kworking\LGPO\WUFBpol.txt -InputObject $POL

#Writes the desired config to the machine LGPO
C:\kworking\lgporun\LGPO.exe /t C:\kworking\LGPO\WUFBpol.txt

#Cleans up and removes unneeded files
Remove-Item -Path C:\kworking\lgporun -Recurse -Force
Remove-Item -Path C:\kworking\LGPO.zip -Force


#All Done!!