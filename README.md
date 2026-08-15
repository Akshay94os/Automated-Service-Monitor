# Automated Service Monitor

A Bash script that checks whether Linux services are running and records the result.

## Run
```bash
chmod +x service_monitor.sh
./service_monitor.sh nginx ssh
```

If no services are supplied, it checks `ssh`, `cron`, and `nginx`.
