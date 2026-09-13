# Local SOC Automation

## Objective

The automation component provides a repeatable method for collecting locally available Windows SOC telemetry from `WIN-SOC01`.

## Evidence Sources

* Windows Security Event Log
* Microsoft Sysmon
* Microsoft Defender Antivirus

## Evidence Collection

The collection script is:

`collect-soc-evidence.ps1`

```powershell

$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"

$OutputRoot = "$env:USERPROFILE\\Desktop\\SOC-Evidence-$Timestamp"



New-Item -Path $OutputRoot -ItemType Directory -Force | Out-Null



Write-Host "SOC evidence collection started."

Write-Host "Output: $OutputRoot"



\# System information

Get-ComputerInfo |

&#x20;   Out-File "$OutputRoot\\system-information.txt"



\# Windows Security - Authentication

Get-WinEvent -FilterHashtable @{

&#x20;   LogName = 'Security'

&#x20;   Id = 4624,4625

} -MaxEvents 200 |

&#x20;   Select-Object TimeCreated, Id, Message |

&#x20;   Out-File "$OutputRoot\\windows-authentication.txt"



\# Windows Security - Process creation

Get-WinEvent -FilterHashtable @{

&#x20;   LogName = 'Security'

&#x20;   Id = 4688

} -MaxEvents 200 |

&#x20;   Select-Object TimeCreated, Id, Message |

&#x20;   Out-File "$OutputRoot\\windows-process-creation.txt"



\# Windows Security - Account management

Get-WinEvent -FilterHashtable @{

&#x20;   LogName = 'Security'

&#x20;   Id = 4720,4728,4732,4740

} -MaxEvents 200 |

&#x20;   Select-Object TimeCreated, Id, Message |

&#x20;   Out-File "$OutputRoot\\windows-account-events.txt"



\# Sysmon - Process creation

Get-WinEvent -FilterHashtable @{

&#x20;   LogName = 'Microsoft-Windows-Sysmon/Operational'

&#x20;   Id = 1

} -MaxEvents 200 |

&#x20;   Select-Object TimeCreated, Id, Message |

&#x20;   Out-File "$OutputRoot\\sysmon-process.txt"



\# Sysmon - Network connection

Get-WinEvent -FilterHashtable @{

&#x20;   LogName = 'Microsoft-Windows-Sysmon/Operational'

&#x20;   Id = 3

} -MaxEvents 200 |

&#x20;   Select-Object TimeCreated, Id, Message |

&#x20;   Out-File "$OutputRoot\\sysmon-network.txt"



\# Sysmon - File creation

Get-WinEvent -FilterHashtable @{

&#x20;   LogName = 'Microsoft-Windows-Sysmon/Operational'

&#x20;   Id = 11

} -MaxEvents 200 |

&#x20;   Select-Object TimeCreated, Id, Message |

&#x20;   Out-File "$OutputRoot\\sysmon-file-creation.txt"



\# Sysmon - Registry value modification

Get-WinEvent -FilterHashtable @{

&#x20;   LogName = 'Microsoft-Windows-Sysmon/Operational'

&#x20;   Id = 13

} -MaxEvents 200 |

&#x20;   Select-Object TimeCreated, Id, Message |

&#x20;   Out-File "$OutputRoot\\sysmon-registry.txt"



\# Sysmon - DNS query

Get-WinEvent -FilterHashtable @{

&#x20;   LogName = 'Microsoft-Windows-Sysmon/Operational'

&#x20;   Id = 22

} -MaxEvents 200 |

&#x20;   Select-Object TimeCreated, Id, Message |

&#x20;   Out-File "$OutputRoot\\sysmon-dns.txt"



\# Microsoft Defender status

Get-MpComputerStatus |

&#x20;   Out-File "$OutputRoot\\defender-status.txt"



\# Microsoft Defender threat detection

Get-MpThreatDetection |

&#x20;   Out-File "$OutputRoot\\defender-threat-detection.txt"



\# Microsoft Defender threat history

Get-MpThreat |

&#x20;   Out-File "$OutputRoot\\defender-threats.txt"



\# Microsoft Defender operational events

Get-WinEvent -FilterHashtable @{

&#x20;   LogName = 'Microsoft-Windows-Windows Defender/Operational'

} -MaxEvents 200 |

&#x20;   Select-Object TimeCreated, Id, Message |

&#x20;   Out-File "$OutputRoot\\defender-operational.txt"



Write-Host ""

Write-Host "SOC evidence collection completed."

Write-Host "Evidence directory:"

Write-Host $OutputRoot
```

The script creates a timestamped evidence directory and collects:

* System information
* Windows authentication events
* Windows process creation events
* Windows account-management events
* Sysmon process events
* Sysmon network events
* Sysmon file creation events
* Sysmon registry events
* Sysmon DNS events
* Microsoft Defender status
* Microsoft Defender threat detection records
* Microsoft Defender threat history
* Microsoft Defender Operational events

## Windows Security Events

The collection includes:

* `4624` — Successful logon
* `4625` — Failed logon
* `4688` — Process creation
* `4720` — User account creation
* `4728` — Global security group membership
* `4732` — Local security group membership
* `4740` — Account lockout

## Sysmon Events

The collection includes:

* Event ID `1` — Process creation
* Event ID `3` — Network connection
* Event ID `11` — File creation
* Event ID `13` — Registry value modification
* Event ID `22` — DNS query

## Microsoft Defender

The collection records:

* Defender protection status
* Defender threat detection records
* Defender threat history
* Defender Operational events

During the validated collection run, the threat detection and threat history files contained no records.

Defender Operational telemetry included configuration-change events (`5007`) and security intelligence update events (`2000`). These events were collected as endpoint telemetry and were not treated as malicious by themselves.

## Validated Evidence Package

```text
SOC-Evidence-20260912-231542/
├── system-information.txt
├── windows-authentication.txt
├── windows-process-creation.txt
├── windows-account-events.txt
├── sysmon-process.txt
├── sysmon-network.txt
├── sysmon-file-creation.txt
├── sysmon-registry.txt
├── sysmon-dns.txt
├── defender-status.txt
├── defender-threat-detection.txt
├── defender-threats.txt
└── defender-operational.txt
```

The package was created successfully on `WIN-SOC01`.

## Investigation Workflow

```text
Windows Security
Sysmon
Defender
      │
      ▼
PowerShell Evidence Collector
      │
      ▼
Timestamped Evidence Package
      │
      ▼
Detection / Threat Hunting
      │
      ▼
SOC Investigation
      │
      ▼
Timeline / Incident Documentation
```

## Validation Status

| Component                    | Status    |
| ---------------------------- | --------- |
| Windows Security collection  | Validated |
| Sysmon collection            | Validated |
| Defender collection          | Validated |
| Timestamped evidence package | Validated |
| Local automation             | Validated |

## Limitations

This is a local endpoint evidence-collection workflow. It is not a replacement for a centralized SIEM or SOAR platform.