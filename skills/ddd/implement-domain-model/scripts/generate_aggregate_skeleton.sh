#!/bin/bash
# Generates a basic DDD Aggregate skeleton in Rust.
set -euo pipefail

# Usage: ./generate_aggregate_skeleton.sh <AggregateRootName>

if [ -z "$1" ]; then
    echo "Usage: $0 <AggregateRootName>"
    exit 1
fi

AGGREGATE_NAME_RAW="$1"
# Convert input (e.g., "my-order") to PascalCase (e.g., "MyOrder")
AGGREGATE_NAME=$(echo "$AGGREGATE_NAME_RAW" | sed 's/\b./\u&/g; s/[-_]//g')

# Convert input to snake_case for filenames (e.g., "my_order")
AGGREGATE_NAME_SNAKE=$(echo "$AGGREGATE_NAME_RAW" | sed 's/\([A-Z]\)/_\L\1/g' | sed -e 's/^_//' | tr '[:upper:]' '[:lower:]')

DIR_PATH="./src/domain/${AGGREGATE_NAME_SNAKE}"
ASSETS_PATH="$(dirname "$0")/../assets"

echo "Generating Aggregate skeleton for: $AGGREGATE_NAME in $DIR_PATH"

mkdir -p "${DIR_PATH}"

# --- Create Aggregate Root file ---
AGGREGATE_ROOT_FILE="${DIR_PATH}/aggregate.rs"
cp "${ASSETS_PATH}/aggregate_root.rs.template" "${AGGREGATE_ROOT_FILE}"
sed -i "s/\[AggregateRootName\]/${AGGREGATE_NAME}/g" "${AGGREGATE_ROOT_FILE}"
echo "Created ${AGGREGATE_ROOT_FILE}"

# --- Create Repository Trait file ---
REPOSITORY_FILE="${DIR_PATH}/repository.rs"
cp "${ASSETS_PATH}/repository_interface.rs.template" "${REPOSITORY_FILE}"
sed -i "s/\[AggregateRootName\]/${AGGREGATE_NAME}/g" "${REPOSITORY_FILE}"
echo "Created ${REPOSITORY_FILE}"

# --- Create mod.rs ---
MOD_FILE="${DIR_PATH}/mod.rs"
cat <<EOL > "${MOD_FILE}"
pub mod aggregate;
pub mod repository;
// pub mod entities; // Uncomment if you have internal entities
// pub mod value_objects; // Uncomment if you have internal value objects
// pub mod domain_services; // Uncomment if you have specific domain services for this aggregate
EOL
echo "Created ${MOD_FILE}"

echo "Aggregate skeleton generation complete. Remember to update your crate's lib.rs or main.rs to include 'pub mod domain;' and 'pub mod ${AGGREGATE_NAME_SNAKE};' where appropriate."
