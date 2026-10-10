# 🔐 SIEM Detection & Incident Investigation Lab

A small SIEM lab where I simulated an SSH brute-force attack against my own Linux VM and investigated it in Kibana, following a SOC-style workflow.

## What this does
- Ships Linux auth logs into Elasticsearch via Filebeat
- Simulates SSH brute-force attacks using Hydra
- Investigates the attack in Kibana Discover, isolating attacker activity from routine system noise
- Produces a formal incident investigation report mapped to MITRE ATT&CK (T1110 - Brute Force)

## Findings
I ran the Hydra attack three times on August 4, 2026. In Kibana, each run appears as bursts of failed SSH logins for the `root` account from `127.0.0.1`. Hydra's four parallel connections show up as several failures landing within the same second.

Filtering Discover on `message: *rhost=127.0.0.1*` separated the attack from routine cron and sudo entries in the same log.

![SSH brute-force authentication failures in Kibana](screenshots/ssh-auth-failure-burst.png)

## Pipeline
```
/var/log/auth.log  →  Filebeat  →  Elasticsearch  →  Kibana Discover
```

Filebeat's `system` module reads the auth log and ships parsed events into Elasticsearch, where they can be searched in Kibana.

![Kibana Discover showing system.auth events](screenshots/kibana-discover-system-auth.png)

## Stack
- Elasticsearch 8.15.0 + Kibana 8.15.0 (containerized via Docker Compose)
- Filebeat 8.15.0 (installed natively on the host, system module/auth fileset)
- THC-Hydra (installed natively, used to simulate the brute-force attack)

## Setup
See `docker-compose.yml` for the Elasticsearch/Kibana stack definition and `passwords.txt` for the test wordlist used in the simulated attack. Full command-by-command setup steps are in `SETUP.md`, including a one-time host setting (`vm.max_map_count`) that Elasticsearch needs to start.

## Report
Full investigation write-up (timeline, IOCs, ATT&CK mapping, remediation): see `SSH_Bruteforce_Investigation_Report.docx`

## Limitations
- **The attack is simulated.** Hydra ran from the same machine (`127.0.0.1`) against my own test VM, so there is no real external attacker traffic and the source IP is not realistic.
- **Detection was manual.** The attack was visible and searchable in the SIEM, and I found it by filtering in Discover. I did not build automated alert rules.
- **This is a lab setup, not a production one.** Elasticsearch security is turned off in `docker-compose.yml` (`xpack.security.enabled=false`) for simplicity. Don't expose these ports to a network you don't control.
