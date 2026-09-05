# 🔐 SIEM Detection & Incident Investigation Lab

A hybrid SIEM pipeline that detects and investigates a simulated SSH 
brute-force attack, modeled on a real SOC workflow.

## What this does
- Ships Linux auth logs into Elasticsearch via Filebeat
- Simulates SSH brute-force attacks using Hydra
- Investigates the attack in Kibana Discover, isolating attacker activity from routine system noise
- Produces a formal incident investigation report mapped to MITRE ATT&CK (T1110 - Brute Force)

## Stack
- Elasticsearch 8.15.0 + Kibana 8.15.0 (containerized via Docker Compose)
- Filebeat 8.15.0 (installed natively on the host, system module/auth fileset)
- THC-Hydra (installed natively, used to simulate the brute-force attack)

## Setup
See `docker-compose.yml` for the Elasticsearch/Kibana stack definition and 
`passwords.txt` for the test wordlist used in the simulated attack. 
Full command-by-command setup steps are in `SETUP.md`.
