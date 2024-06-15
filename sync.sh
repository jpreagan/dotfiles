#!/bin/bash

# Function to sync directories and handle conflicts
sync_directories() {
  src=$1
  dest=$2
  exclude1=$3
  exclude2=$4
  
  # Perform a dry run to detect conflicts
  conflicts=$(rsync -nrv --exclude="$exclude1" --exclude="$exclude2" "$src/" "$dest/" | grep -E '^deleting|^[<>]f\+\+\+\+\+')
  
  if [ -n "$conflicts" ]; then
    echo "Conflicts detected between $src and $dest:"
    echo "$conflicts"
    echo "Please resolve these conflicts manually."
    exit 1
  fi
  
  # Sync the directories if no conflicts are detected
  rsync -av --exclude="$exclude1" --exclude="$exclude2" "$src/" "$dest/"
}

# Sync from darwin to linux, excluding specified directories
sync_directories "darwin" "linux" ".config/alacritty" ".config/skhd"

# Sync from linux to darwin, excluding specified directories
sync_directories "linux" "darwin" ".config/alacritty" ".config/skhd"

