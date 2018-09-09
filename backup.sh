#!/bin/sh

FULL_BACKUP_FREQ="2M"
BACKUP_LIFESPAN="2Y"

USER="$(whoami)"
HOST="$(hostname)"

SRC="/home/$USER"
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
DEST="file://$SCRIPT_DIR/$HOST/$USER"

# Take backup
duplicity --progress --full-if-older-than "$FULL_BACKUP_FREQ" --exclude "**/node_modules" --exclude "**/.git" "$SRC" "$DEST"

# Remove old backups
duplicity remove-older-than "$BACKUP_LIFESPAN" --force --progress "$DEST"
