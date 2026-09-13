# Microsoft Windows SOC Lab

A simulated Windows SOC laboratory built with VMware virtual machines to demonstrate Windows Security monitoring, Sysmon telemetry, Microsoft Defender investigation, detection engineering, threat hunting, incident response and local SOC evidence automation.

Kali Linux is used for controlled adversary simulation, while Ubuntu Server is used for SOC investigation support and evidence organization.

## Project Overview

This project demonstrates an end-to-end local SOC workflow:

```text
Lab Setup
   ↓
Windows Security + Sysmon + Defender
   ↓
Detection Engineering
   ↓
Threat Hunting
   ↓
Controlled Adversary Simulation
   ↓
Incident Investigation
   ↓
Incident Response
   ↓
Automated Evidence Collection
   ↓
Evidence / Timeline / Reporting
```

The project was built and validated in an isolated VMware laboratory using real endpoint telemetry generated during controlled testing.

## Objectives

- Build an isolated Windows SOC laboratory
- Collect and analyze Windows Security telemetry
- Deploy and validate Sysmon telemetry
- Validate Microsoft Defender security telemetry
- Develop local SOC detection logic
- Perform threat hunting using endpoint telemetry
- Conduct controlled adversary simulation
- Investigate authentication, process and network activity
- Create an incident timeline and investigation report
- Automate local SOC evidence collection with PowerShell
- Organize evidence using an Ubuntu SOC support system

## Lab Environment

| System         | Role                             | IP Address      |
| -------------- | -------------------------------- | --------------- |
| `WIN-SOC01`    | Windows SOC endpoint             | `192.168.50.20` |
| `Kali`         | Controlled adversary simulation  | `192.168.50.10` |
| `LINUX-SRV-01` | Ubuntu SOC investigation/support | `192.168.50.30` |

### Technologies and Tools

- VMware Workstation
- VMware VMnet10 Host-only Network
- Windows 10 Pro
- Kali Linux
- Ubuntu Server
- Windows Security Event Log
- Windows Audit Policy / `auditpol`
- PowerShell
- Microsoft Sysmon
- Microsoft Defender Antivirus
- Nmap
- FreeRDP (`xfreerdp`)
- RDP / Remote Desktop
- SMB / Microsoft-DS
- SSH / SCP
- Detection Engineering
- Threat Hunting
- Event and Timeline Analysis
- Network Reconnaissance & Service Enumeration
- Authentication Analysis
- Process Analysis
- Incident Response
- MITRE ATT&CK

## Day 1 - Lab architecture and infrastructure

Validation status and lab setup details are documented in:

`documentation/lab-setup.md`

## Day 1 Architecture

```text
                         VMware Workstation
                                │
                              VMnet10
                         192.168.50.0/24
                                │
              ┌─────────────────┼─────────────────┐
              │                 │                 │
            Kali            WIN-SOC01        LINUX-SRV-01
        192.168.50.10     192.168.50.20     192.168.50.30
         Adversary          Windows             SOC
        Simulation         Endpoint           Support
        
```

## Day 2 - Windows Security Telemetry + Sysmon

## Windows Security Telemetry

The Windows endpoint is configured to generate security
telemetry used for SOC monitoring and detection engineering.

Validation status and actual observations are documented in:

`documentation/windows-endpoint.md`

## Sysmon Telemetry

Sysmon is deployed on WIN-SOC01 to provide additional
endpoint telemetry.

Validation status is documented in:

`documentation/sysmon.md`

## Day 2 Architecture

```text
                    VMware Workstation
                           │
                         VMnet10
                    192.168.50.0/24
                           │
          ┌────────────────┼────────────────┐
          │                │                │
      WIN-SOC01           Kali        LINUX-SRV-01
      192.168.50.20   192.168.50.10    192.168.50.30
          │
          ├── Windows Security Events
          └── Sysmon

```

## Day 3 - Microsoft Defender Security Telemetry

Microsoft Defender Antivirus is validated on WIN-SOC01
to provide endpoint protection status, security intelligence,
scan activity, threat history and Defender operational telemetry.

Validation status and actual observations are documented in:

`documentation/defender.md`

## Microsoft Defender Telemetry

The Windows endpoint was validated for:

- Microsoft Defender Antivirus status
- Real-time protection
- Behavior monitoring
- IOAV protection
- Network Inspection System (NIS)
- Security intelligence / signature state
- Quick Scan execution
- Defender threat history
- Defender Operational event logging

The Day 3 validation was performed locally on WIN-SOC01.

## Day 3 Architecture

```text
                    VMware Workstation
                           │
                         VMnet10
                    192.168.50.0/24
                           │
          ┌────────────────┼────────────────┐
          │                │                │
      WIN-SOC01           Kali        LINUX-SRV-01
      192.168.50.20   192.168.50.10    192.168.50.30
          │
          ├── Windows Security Events
          ├── Sysmon
          └── Microsoft Defender
                  │
                  ├── Protection Status
                  ├── Security Intelligence
                  ├── Scan Activity
                  └── Defender Operational Logs

```

## Day 4 - Local Detection Engineering

The Windows Security, Sysmon and Microsoft Defender telemetry
validated during the previous phases is used to develop and
validate local SOC detection logic.

Validation status and actual detection logic are documented in:

`detections/`

### Detection Files

- `detections/brute-force.md`
- `detections/suspicious-powershell.md`
- `detections/user-creation.md`
- `detections/suspicious-process.md`
- `detections/network-activity.md`

## Detection Engineering

The following detection areas were validated locally on WIN-SOC01:

- Failed logon activity
- Suspicious PowerShell
- User account creation
- Suspicious process execution
- Network activity

The detections use Windows Security and Sysmon telemetry.
Each detection documents the data source, event ID, detection
logic, observed result, analyst interpretation, validation status.

PowerShell and process execution detections are based on
process creation telemetry and require analyst review of
command-line and process context.

## Day 4 Architecture

```text    
                    VMware Workstation
                           │
                         VMnet10
                    192.168.50.0/24
                           │
          ┌────────────────┼────────────────┐
          │                │                │
      WIN-SOC01           Kali        LINUX-SRV-01
      192.168.50.20   192.168.50.10    192.168.50.30
          │
          ├── Windows Security Events
          ├── Sysmon
          └── Microsoft Defender
                           │
                           ▼
                  Detection Engineering
                           │
                 ┌─────────┼─────────┐
                 │         │         │
               Logon     PowerShell  Account
              Detection   Detection  Detection
                 │         │         │
                 ├─────────┼─────────┤
                 │                   │
               Process          Network
              Detection         Detection
                 │                   │
                 └─────────┬─────────┘
                           ▼
                      SOC Analysis      
                                            
```

## Day 5 - Local Threat Hunting

The Windows Security, Sysmon and Microsoft Defender telemetry
validated during the previous phases is used for local threat
hunting and contextual analysis.

Validation status and actual hunting activities are documented in:

`hunting/`

### Hunting Files

* `hunting/authentication-hunting.md`
* `hunting/powershell-hunting.md`
* `hunting/process-hunting.md`
* `hunting/network-hunting.md`
* `hunting/dns-hunting.md`
* `hunting/defender-hunting.md`

## Threat Hunting

The following hunting areas were validated locally on WIN-SOC01:

* Authentication activity
* PowerShell activity
* Process creation
* Network connections
* DNS queries
* Microsoft Defender telemetry

The hunting process uses Windows Security, Sysmon and Microsoft
Defender telemetry to identify activity requiring further
investigation.

Hunting results are reviewed using event details, process context,
user information, network information and available security
telemetry.

Observed activity is not automatically classified as malicious.
Contextual analysis is used to distinguish controlled tests,
normal system activity and activity requiring further investigation.

## Day 5 Architecture

```text
                    VMware Workstation
                           │
                         VMnet10
                    192.168.50.0/24
                           │
          ┌────────────────┼────────────────┐
          │                │                │
      WIN-SOC01           Kali        LINUX-SRV-01
      192.168.50.20   192.168.50.10    192.168.50.30
          │
          ├── Windows Security Events
          ├── Sysmon
          └── Microsoft Defender
                           │
                           ▼
                  Detection Engineering
                           │
                           ▼
                     Threat Hunting
                           │
              ┌────────────┼────────────┐
              │            │            │
        Authentication  PowerShell    Process
              │            │            │
              ├────────────┼────────────┤
              │            │            │
           Network        DNS       Defender
              │            │            │
              └────────────┼────────────┘
                           ▼
                   Contextual Analysis
                           │
                           ▼
                      SOC Analysis

```
## Day 6 - Controlled Adversary Simulation & Incident Response

A controlled adversary simulation was conducted from Kali against `WIN-SOC01` within the isolated VMware SOC laboratory to validate attack visibility, endpoint telemetry and incident investigation workflows.

The exercise covered:

* Network reconnaissance
* Service enumeration
* RDP service validation
* Controlled authentication testing
* Windows Security investigation
* Sysmon process investigation
* Microsoft Defender investigation
* Ubuntu-based SOC investigation
* Incident timeline creation
* Containment and cleanup

The complete incident investigation, evidence and timeline are documented in:

`incidents/incident-001.md`

## Day 6 Architecture

```text
                    VMware Workstation
                           │
                         VMnet10
                    192.168.50.0/24
                           │
          ┌────────────────┼────────────────┐
          │                │                │
        Kali           WIN-SOC01       LINUX-SRV-01
     192.168.50.10    192.168.50.20    192.168.50.30
          │                │                │
          ▼                │                │
   Adversary Simulation    │                │
          │                │                │
          └───────────────►│                │
                           │                │
                  ┌────────┴────────┐       │
                  │                 │       │
             Windows Security    Sysmon     │
                  │                 │       │
                  └────────┬────────┘       │
                           │           Ubuntu SOC Support
                           ▼                ▼
                       SOC Investigation
                              │
                              ▼
                       Incident Response

```
## Day 7 - Local SOC Automation & Evidence Collection

A PowerShell-based local SOC evidence collection workflow was implemented on `WIN-SOC01`.

The automation collects:

* Windows Security authentication, process and account events
* Sysmon process, network, file, registry and DNS events
* Microsoft Defender status and operational events
* Defender threat detection and threat history records

The validated collection generated a timestamped evidence package containing 13 files.

The evidence was transferred to the Ubuntu SOC workspace for organization and then added to the project repository.

```text
evidence/
└── incident-001/
    └── SOC-Evidence-20260912-231542/
        └── 13 evidence files
```

The automation script is available in:

`automation/collect-soc-evidence.ps1`

The automation documentation is available in:

`automation/README.md`

```text
 
                    WIN-SOC01
                       │
          ┌────────────┼────────────┐
          │            │            │
       Security       Sysmon      Defender
          │            │            │
          └────────────┼────────────┘
                       ▼
             PowerShell Collector
                       │
                       ▼
           Timestamped Evidence
                       │
                       ▼
                  Ubuntu SOC
                 192.168.50.30
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
      Evidence       Reports      Timeline
          │            │            │
          └────────────┼────────────┘
                       ▼
                GitHub Project
```

# Final Project Architecture

## 1. Final Lab Architecture

```text
                         VMware Workstation
                                │
                              VMnet10
                         192.168.50.0/24
                                │
             ┌──────────────────┼──────────────────┐
             │                  │                  │
           Kali            WIN-SOC01         LINUX-SRV-01
       192.168.50.10       192.168.50.20       192.168.50.30
        Adversary             Windows              SOC
       Simulation            Endpoint            Support
```

## 2. Final Telemetry Architecture

```text
                         WIN-SOC01
                             │
              ┌──────────────┼──────────────┐
              │              │              │
        Windows Security    Sysmon       Defender
              │              │              │
              ▼              ▼              ▼
        Authentication   Process        Protection
        Process           Network        Status
        Accounts          File           Scans
                          Registry        Operational
                          DNS
              │              │              │
              └──────────────┼──────────────┘
                             ▼
                       Local SOC Data
```

## 3. Detection and Hunting Architecture

```text
                    Local SOC Telemetry
                             │
          ┌──────────────────┼──────────────────┐
          │                  │                  │
     Windows Security      Sysmon            Defender
          │                  │                  │
          └──────────────────┼──────────────────┘
                             ▼
                  Detection Engineering
                             │
                             ▼
                       Threat Hunting
                             │
                             ▼
                    Contextual Analysis
                             │
                             ▼
                       SOC Investigation
```

## 4. Adversary Simulation and Incident Response Architecture

```text
                         Kali
                    192.168.50.10
                           │
                           ▼
                 Network Reconnaissance
                           │
                           ▼
                  Service Enumeration
                           │
                           ▼
                 Controlled RDP Testing
                           │
                           ▼
                      WIN-SOC01
                    192.168.50.20
                           │
             ┌─────────────┼─────────────┐
             │             │             │
        Authentication   Sysmon       Defender
             │             │             │
             └─────────────┼─────────────┘
                           ▼
                    SOC Investigation
                           │
                           ▼
                     Timeline Analysis
                           │
                           ▼
                  Incident Response
                           │
                           ▼
                   Containment/Cleanup
```

## 5. Automation and Evidence Architecture

```text
                     WIN-SOC01
                         │
              PowerShell Evidence Collector
                         │
        ┌────────────────┼────────────────┐
        │                │                │
 Windows Security      Sysmon          Defender
        │                │                │
        └────────────────┼────────────────┘
                         ▼
              Timestamped Evidence Package
                         │
                         ▼
                       Ubuntu
                  SOC Organization
                         │
             ┌───────────┼───────────┐
             │           │           │
          Evidence     Reports     Timelines
             │           │           │
             └───────────┼───────────┘
                         ▼
                    GitHub Project
```


## Project Limitations

Microsoft Sentinel, Log Analytics Workspace, Microsoft Entra ID
and Sentinel-based KQL are not implemented in the current
laboratory because an Azure subscription is not available.

The project therefore focuses on locally validated Windows
Security telemetry, Sysmon telemetry, Microsoft Defender,
detection engineering, threat hunting and incident response.

Cloud-based Sentinel ingestion and Sentinel analytics rules
are outside the validated scope of this implementation.

## Security and Testing Scope

All adversary simulation and authentication testing was performed inside the isolated VMware laboratory.

No malware or uncontrolled external targets were used.

The project is intended for cybersecurity learning, SOC workflow demonstration and portfolio purposes.

## Project Outcome

The completed laboratory demonstrates a local SOC workflow from endpoint telemetry collection through detection, hunting, controlled adversary simulation, incident investigation, evidence collection, timeline creation and incident reporting.
