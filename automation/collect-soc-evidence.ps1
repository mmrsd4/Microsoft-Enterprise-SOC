$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$OutputRoot = "$env:USERPROFILE\Desktop\SOC-Evidence-$Timestamp"

New-Item -Path $OutputRoot -ItemType Directory -Force | Out-Null

Write-Host "SOC evidence collection started."
Write-Host "Output: $OutputRoot"

# System information
Get-ComputerInfo |
    Out-File "$OutputRoot\system-information.txt"

# Windows Security - Authentication
Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    Id = 4624,4625
} -MaxEvents 200 |
    Select-Object TimeCreated, Id, Message |
    Out-File "$OutputRoot\windows-authentication.txt"

# Windows Security - Process creation
Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    Id = 4688
} -MaxEvents 200 |
    Select-Object TimeCreated, Id, Message |
    Out-File "$OutputRoot\windows-process-creation.txt"

# Windows Security - Account management
Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    Id = 4720,4728,4732,4740
} -MaxEvents 200 |
    Select-Object TimeCreated, Id, Message |
    Out-File "$OutputRoot\windows-account-events.txt"

# Sysmon - Process creation
Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-Sysmon/Operational'
    Id = 1
} -MaxEvents 200 |
    Select-Object TimeCreated, Id, Message |
    Out-File "$OutputRoot\sysmon-process.txt"

# Sysmon - Network connection
Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-Sysmon/Operational'
    Id = 3
} -MaxEvents 200 |
    Select-Object TimeCreated, Id, Message |
    Out-File "$OutputRoot\sysmon-network.txt"

# Sysmon - File creation
Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-Sysmon/Operational'
    Id = 11
} -MaxEvents 200 |
    Select-Object TimeCreated, Id, Message |
    Out-File "$OutputRoot\sysmon-file-creation.txt"

# Sysmon - Registry value modification
Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-Sysmon/Operational'
    Id = 13
} -MaxEvents 200 |
    Select-Object TimeCreated, Id, Message |
    Out-File "$OutputRoot\sysmon-registry.txt"

# Sysmon - DNS query
Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-Sysmon/Operational'
    Id = 22
} -MaxEvents 200 |
    Select-Object TimeCreated, Id, Message |
    Out-File "$OutputRoot\sysmon-dns.txt"

# Microsoft Defender status
Get-MpComputerStatus |
    Out-File "$OutputRoot\defender-status.txt"

# Microsoft Defender threat detection
Get-MpThreatDetection |
    Out-File "$OutputRoot\defender-threat-detection.txt"

# Microsoft Defender threat history
Get-MpThreat |
    Out-File "$OutputRoot\defender-threats.txt"

# Microsoft Defender operational events
Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-Windows Defender/Operational'
} -MaxEvents 200 |
    Select-Object TimeCreated, Id, Message |
    Out-File "$OutputRoot\defender-operational.txt"

Write-Host ""
Write-Host "SOC evidence collection completed."
Write-Host "Evidence directory:"
Write-Host $OutputRoot