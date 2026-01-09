# GCP Shell Monitor

A lightweight Bash-based monitoring tool to fetch and log Google Cloud Platform (GCP) resource details such as:

- GCP Projects
- Compute Engine instances
- Cloud Storage buckets

All outputs are written to timestamped log files for easy auditing and troubleshooting.

---

## 📌 Features

- Fetches GCP project details
- Lists Compute Engine VM instances
- Lists Cloud Storage buckets
- Generates date-based log files


---

## 🗂 Project Structure

```text
gcp-shell-monitor/
├── scripts/
│   └── gcp_monitor.sh        # Main monitoring script
├── logs/
│   └── *.log                 # Runtime logs (gitignored)
├── .gitignore
├── README.md
