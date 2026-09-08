# Sysmon

## Objective

Install and validate Sysmon on `WIN-SOC01` to provide additional endpoint telemetry for process, network, file, registry, and DNS activity.

## Installation

Sysmon is installed on `WIN-SOC01` and the `Sysmon64` service is running.

The Sysmon installation was validated using:

```powershell
Get-Service Sysmon64
```

## Configuration

Sysmon is configured to generate endpoint telemetry.
The validated events in the current environment include:
Event ID 1 — Process creation
Event ID 3 — Network connection
Event ID 11 — File creation
Event ID 13 — Registry value set
Event ID 22 — DNS query

## Sysmon Service Validation

The Sysmon service was checked with:

```powershell
Get-Service Sysmon64
```

Result:
Status   Name      DisplayName
------   ----      -----------
Running  Sysmon64  Sysmon64

The Sysmon Operational log was also verified:

Microsoft-Windows-Sysmon/Operational

Log status:
Enabled: True
Records: 49,089
This confirms that Sysmon is installed, running, and writing events to the Operational log.

## Validation Results

| Event ID | Activity                        | Status        |
| -------- | ------------------------------- | ------------- |
| 1        | Process creation                | VALIDATED     |
| 3        | Network connection              | VALIDATED     |
| 7        | Image loaded                    | VALIDATED     |
| 10       | Process access                  | VALIDATED     |
| 11       | File creation                   | VALIDATED     |
| 12       | Registry object created/deleted | VALIDATED     |
| 13       | Registry value set              | VALIDATED     |
| 22       | DNS query                       | VALIDATED     |

## Detection Opportunities

The validated Sysmon telemetry provides a foundation for detecting and investigating:
Suspicious process creation
Unexpected network connections
Suspicious file creation
Registry value modifications
DNS activity associated with endpoint processes

## Evidence

screenshots/
├── DAY02-05-sysmon-installed.png
├── DAY02-06-sysmon-event-1.png
├── DAY02-07-sysmon-event-3.png
└── DAY02-08-sysmon-event-22.png
