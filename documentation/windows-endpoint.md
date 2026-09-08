# Windows Endpoint Telemetry

## Objective

Configure and validate Windows Security auditing on `WIN-SOC01` and verify that useful security events are generated locally.

## Endpoint

- Hostname: `WIN-SOC01`
- Operating System: Windows 10 Pro
- Windows Event Log: Running
- Security Log: Enabled
- Security Log Records: 24,240

## Windows Security Auditing

The Windows audit policy was checked and the required subcategories were enabled for successful and failed activity.

Validated audit settings:

| Audit Subcategory | Setting |
|---------------------------|---------------------|
| Logon                     | Success and Failure |
| Account Lockout           | Success and Failure |
| User Account Management   | Success and Failure |
| Security Group Management | Success and Failure |
| Process Creation          | Success and Failure |

The audit policy was verified using:

```powershell
auditpol /get /category:*

## Validation Results

Event ID  Activity	                           Status
4624      Successful logon                      VALIDATED
4625      Failed logon	                     VALIDATED
4688      Process creation	                     VALIDATED
4720      User account creation                 VALIDATED
4728      Global security group modification    VALIDATED
4732      Local security group modification     VALIDATED
4740      Account lockout                       VALIDATED

## Detection Opportunities

The validated Windows Security telemetry provides a foundation for detecting:
Repeated failed authentication attempts
Suspicious successful logons
New local user accounts
Unexpected security group membership changes
Account lockout activity
Suspicious process creation

## Evidence

screenshots/
├── DAY02-01-windows-auditing.png
├── DAY02-02-security-event-4624.png
├── DAY02-03-security-event-4625.png
└── DAY02-04-security-event-4688.png
