#Set group policy objects for windows update for business. This will probably only work for Windows 10

#defer feature updates
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name DeferFeatureUpdates -Value 1
#set when feature updates are received (default deferrment is 90 days)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name DeferFeatureUpdatesPeriodInDays -Value 90
#defer quality updates
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name DeferQualityUpdates -Value 1
#set when quality updates are installed (default deferrment is 14 days)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name DeferQualityUpdatesPeriodInDays -Value 14
#make sure wufb safeguards are on
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name DisableWUfBSafeguards -Value 0
#disable preview builds     
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name ManagePreviewBuilds -Value 1
#disable preview builds
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name ManagePreviewBuildsPolicyValue -Value 0


