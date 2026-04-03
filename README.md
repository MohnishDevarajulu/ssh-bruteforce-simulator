## What This Lab Demonstrates

1. **Attack Simulation:** Successfully brute-forced SSH using Hydra (14 attempts, 11 seconds)

2. **Manual Log Analysis:** Used `tail -f /var/log/auth.log` to watch failures in real-time

3. **Detection Concept:** Observed that multiple failures followed by success = clear compromise indicator

## Detection Script (Conceptual)

While this lab focused on manual observation, a production detection script would:
- Count failures per IP in 5-minute windows
- Alert when threshold exceeds 5 attempts
- Flag success after multiple failures
