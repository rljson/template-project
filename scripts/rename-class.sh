#!/bin/bash

# Validate CLI-Params
if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 <CLASS_A> <CLASS_B>"
    exit 1
fi

export CLASS_A="$1"
export CLASS_B="$2"

# Set platform dependent sed-variant
if [[ "$OSTYPE" == "darwin"* ]]; then
    SED_CMD="sed -i ''"
else
    SED_CMD="sed -i"
fi

# Methods for name conversion
to_snake_case() {
    echo "$1" | perl -pe 's/(?<=[a-z0-9])([A-Z])/-\L$1/g'
}

to_lower_first() {
    first_char=$(echo "$1" | cut -c1 | tr '[:upper:]' '[:lower:]')
    rest_chars=$(echo "$1" | cut -c2-)
    echo "$first_char$rest_chars"
}

export LOWER_CLASS_A=$(to_lower_first "$CLASS_A")
export LOWER_CLASS_B=$(to_lower_first "$CLASS_B")
export SNAKE_CLASS_A=$(to_snake_case "$CLASS_A")
export SNAKE_CLASS_B=$(to_snake_case "$CLASS_B")

# Replace in files
find . -type f \( -name "*.ts" -o -name "*.md" -o -name "package.json" \) \
    ! -path "*/.*/*" ! -path "*/node_modules/*" \
    -exec $SED_CMD "s/$CLASS_A/$CLASS_B/g" {} +

find . -type f \( -name "*.ts" -o -name "*.md" -o -name "package.json" \) \
    ! -path "*/.*/*" ! -path "*/node_modules/*" \
    -exec $SED_CMD "s/$LOWER_CLASS_A/$LOWER_CLASS_B/g" {} +

find . -type f \( -name "*.ts" -o -name "*.md" -o -name "package.json" \) \
    ! -path "*/.*/*" ! -path "*/node_modules/*" \
    -exec $SED_CMD "s/$SNAKE_CLASS_A/$SNAKE_CLASS_B/g" {} +

# Rename files
find . -type f ! -path "*/.*/*" ! -path "*/node_modules/*" -name "*$SNAKE_CLASS_A*" \
    -exec bash -c 'mv "$1" "${1//'"$SNAKE_CLASS_A"'/'"$SNAKE_CLASS_B"'}"' _ {} \;

# Update goldens
rm -rf test/goldens
pnpm updateGoldens
