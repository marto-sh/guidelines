#!/bin/bash
# Initializes a new BDD .feature file from a template.
set -euo pipefail

# Usage: ./init_bdd_feature.sh <FeatureName>

if [ -z "$1" ]; then
    echo "Usage: $0 <FeatureName>"
    exit 1
fi

FEATURE_NAME_RAW="$1"
FEATURE_NAME_KEBAB=$(echo "$FEATURE_NAME_RAW" | sed 's/ /-/g' | sed 's/\([A-Z]\)/-\L\1/g' | sed -e 's/^-//' | sed 's/--/-/g' | tr '[:upper:]' '[:lower:]')

DIR_PATH="./features" # Default directory for BDD feature files
ASSETS_PATH="$(dirname "$0")/../assets"

echo "Initializing BDD Feature: $FEATURE_NAME_RAW in $DIR_PATH/${FEATURE_NAME_KEBAB}.feature"

mkdir -p "${DIR_PATH}"

FEATURE_FILE="${DIR_PATH}/${FEATURE_NAME_KEBAB}.feature"
cp "${ASSETS_PATH}/bdd_feature.template" "${FEATURE_FILE}"
sed -i "s/\[Feature Title\]/${FEATURE_NAME_RAW}/g" "${FEATURE_FILE}"

echo "Created ${FEATURE_FILE}. Please review and update the placeholders."
