# Microsoft Enterprise SOC

Enterprise-style SOC laboratory built around Microsoft Sentinel,
Windows telemetry, Sysmon, Microsoft Defender, Microsoft Entra ID,
KQL, detection engineering, threat hunting and incident response.

## Project Status

Day 1 — Lab architecture and infrastructure

## Lab Environment

- VMware Workstation
- Windows endpoint: WIN-SOC01
- Kali Linux
- Ubuntu Server

## Architecture

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