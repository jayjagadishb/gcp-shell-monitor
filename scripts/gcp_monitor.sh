#!/bin/bash


# -------- Logging Setup --------
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_DIR="$BASE_DIR/logs"
DATE=$(date +"%Y-%m-%d")
LOG_FILE="$LOG_DIR/gcp_monitor_$(DATE +%F).log"
#LOG_FILE="logs/gcp_monitor_$(date +%F).log"


mkdir -p "$LOG_DIR"

exec >> "$LOG_FILE" 2>&1
# --------------------------------

# ============================================
# Script Name : gcp_monitor.sh
# Purpose     : Monitor GCP resources using gcloud CLI
# Author      : Jay Jagadish Behera
# Usage       : ./gcp_monitor.sh <compute|storage|project>
# ============================================

LOG_FILE="../logs/gcp_monitor.log"

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" | tee -a "$LOG_FILE"
}

# Validate argument
if [ $# -ne 1 ]; then
  log "ERROR: Invalid arguments"
  echo "Usage: $0 {compute|storage|project}"
  exit 1
fi

SERVICE=$1

# Check gcloud installation
if ! command -v gcloud &>/dev/null; then
  log "ERROR: gcloud CLI not installed"
  exit 1
fi

# Check authentication
ACTIVE_ACCOUNT=$(gcloud auth list --filter=status:ACTIVE --format="value(account)")
if [ -z "$ACTIVE_ACCOUNT" ]; then
  log "ERROR: gcloud not authenticated"
  exit 1
fi

log "Authenticated as $ACTIVE_ACCOUNT"

case $SERVICE in
  compute)
    log "Listing Compute Engine instances"
    gcloud compute instances list
    ;;
  storage)
    log "Listing Cloud Storage buckets"
    gcloud storage buckets list
    ;;
  project)
    log "Showing project details"
    gcloud projects describe $(gcloud config get-value project)
    ;;
  *)
    log "ERROR: Invalid service input"
    exit 1
    ;;
esac

log "Script execution completed successfully"
