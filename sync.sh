#!/bin/bash

# Function to sync directories and handle conflicts
sync_directories() {
  src=$1
  dest=$2
  excludes=("${@:3}")
  
  # Build the rsync exclude parameters
  exclude_params=()
  for exclude in "${excludes[@]}"; do
    exclude_params+=("--exclude=${exclude}")
  done
  
  # Perform a dry run to detect conflicts
  conflicts=$(rsync -nrv "${exclude_params[@]}" "$src/" "$dest/" | grep -E '^deleting|^[<>]f\+\+\+\+\+')
  
  if [ -n "$conflicts" ]; then
    echo "Conflicts detected between $src and $dest:"
    echo "$conflicts"
    echo "Please resolve these conflicts manually."
    exit 1
  fi
  
  # Sync the directories if no conflicts are detected
  rsync -av "${exclude_params[@]}" "$src/" "$dest/"
}

# Exclusions for syncing from darwin to linux
exclusions_darwin_to_linux=(".config/alacritty" ".config/skhd" ".local/bin/upgrade")

# Exclusions for syncing from linux to darwin
exclusions_linux_to_darwin=(".local/bin/upgrade")

# Sync from darwin to linux, excluding specified directories
sync_directories "darwin" "linux" "${exclusions_darwin_to_linux[@]}"

# Sync from linux to darwin, excluding specified directories
sync_directories "linux" "darwin" "${exclusions_linux_to_darwin[@]}"

