#!/bin/bash

# Define the version file path
VERSION_FILE="version.txt"

# Check if the version file exists
if [ ! -f $VERSION_FILE ]; then
    echo "Warning: Version file '$VERSION_FILE' not found!"
    exit 0
fi

# Extract the current version from the file in the working directory
new_version=$(grep -Eo '([0-9]+\.[0-9]+\.[0-9]+)' $VERSION_FILE)

# Get the last committed version of the file
old_version=$(git show HEAD:$VERSION_FILE | grep -Eo '([0-9]+\.[0-9]+\.[0-9]+)')

# Check if both versions are not empty
if [ -z "$new_version" ] || [ -z "$old_version" ]; then
    echo "Warning: Could not find version numbers in the file."
    exit 0
fi

# Compare the versions
if [ "$(printf '%s\n' "$old_version" "$new_version" | sort -V | head -n1)" == "$new_version" ] && [ "$new_version" != "$old_version" ]; then
    echo "Warning: The new version number ($new_version) is lower or equal to the previous version number ($old_version)."
fi
