## Prerequisites
- Ubuntu VM (VMware/VirtualBox)
- Internet connection for installing tools
- Terminal access with sudo privileges

# Setup Steps

## 0. One-time host prerequisite
Elasticsearch requires a higher virtual memory map count than most Linux 
distros allow by default. Set this before starting the stack, or 
Elasticsearch may crash on startup:

sudo sysctl -w vm.max_map_count=262144
echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf

## 1. Start the SIEM stack (Elasticsearch + Kibana)
docker compose up -d

Confirm both containers are healthy:
docker ps
curl http://localhost:9200

## 2. Install and configure Filebeat (native, not containerized)
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.15.0-amd64.deb
sudo dpkg -i filebeat-8.15.0-amd64.deb
sudo filebeat modules enable system

Edit /etc/filebeat/modules.d/system.yml and enable the auth fileset 
(this must be explicitly enabled or Filebeat will fail to start with 
a "module has no enabled filesets" error):
- module: system
  auth:
    enabled: true

Then initialize and start Filebeat:
sudo filebeat setup
sudo systemctl enable --now filebeat

## 3. Verify data is flowing into Elasticsearch
curl http://localhost:9200/filebeat-*/_count

## 4. Simulate the attack
sudo apt install -y hydra
hydra -l root -P passwords.txt ssh://127.0.0.1 -t 4

## 5. Investigate in Kibana
Open http://localhost:5601 -> Analytics -> Discover
Select the filebeat-* data view
Widen the time range to cover the attack window
Filter using: message: *rhost=127.0.0.1*

This isolates the brute-force authentication failures from routine 
system noise (cron jobs, sudo sessions, desktop auth agents) and 
produces the timeline documented in the investigation report.
