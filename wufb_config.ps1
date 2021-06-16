#Set group policy objects for windows update for business. This will probably only work for Windows 10

#install group policy management tools
Add-WindowsCapability -Online -Name Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0


