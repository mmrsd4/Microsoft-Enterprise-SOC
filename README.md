# Microsoft Enterprise SOC

Enterprise-style SOC laboratory built around Microsoft Sentinel,
Windows telemetry, Sysmon, Microsoft Defender, KQL, detection engineering,
threat hunting and incident response.

## Lab Environment

- VMware Workstation
- Windows endpoint: WIN-SOC01
- Kali Linux
- Ubuntu Server

## Project Status

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
          ┌────────────────┼────────────────┐
          │                │                │
      WIN-SOC01           Kali        LINUX-SRV-01
      192.168.50.20   192.168.50.10    192.168.50.30

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