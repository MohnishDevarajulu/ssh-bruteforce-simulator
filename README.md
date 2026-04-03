# 🔐 SSH Brute-Force Attack Simulator & Detection Lab

## Overview
Simulated SSH brute-force attack against Ubuntu VM with custom detection script.

## Results
- **Target:** testuser@127.0.0.1:22
- **Password found:** BadPasswd123
- **Attempts:** 14 | **Time:** 11 seconds

## Detection Script
```bash
./detect-brute.sh
# Alerts on >5 failed attempts in 5 minutes
