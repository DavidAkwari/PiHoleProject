#!/bin/bash
# Automated Pi hole teleporter backup script

BACKUP_DEST="/home/david/pi_hole_backups"

mkdir -p "$BACKUP_DEST"
cd "$BACKUP_DEST" || exit

pihole -a -t

find "$BACKUP_DEST" -type f -name "*.tar.gz" -mtime +30 -exec rm {} \;
