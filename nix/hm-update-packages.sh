#!/usr/bin/env bash

echo "Updating home-manager packages..."

# This script will update all our home-manager packages to the latest version, commit the
# updated lock file, and display which packages were updated.

# Get the current generation, so we can compare it to the new generation after updating
LATEST_BEFORE_UPDATE=$(home-manager generations | head -n 1 | awk '{print $7}')

# Update all packages and commit the updated lock file
DIR=$(dirname "$0")
nix flake update --flake "$DIR" --commit-lock-file

# Get the new generation
LATEST_AFTER_UPDATE=$(home-manager generations | head -n 1 | awk '{print $7}')

# Display which packages were updated
nix store diff-closures $LATEST_BEFORE_UPDATE $LATEST_AFTER_UPDATE

echo "Finished updating home-manager packages."
