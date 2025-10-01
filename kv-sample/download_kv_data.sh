#!/bin/bash

keys=(
  "Cold-Dry-Breeze"
  "Cold-Dry-Calm"
  "Cold-Dry-Windy"
  "Cold-Rain-Breeze"
  "Cold-Rain-Calm"
  "Cold-Rain-Windy"
  "Cool-Dry-Breeze"
  "Cool-Dry-Calm"
  "Cool-Dry-Windy"
  "Cool-Rain-Breeze"
  "Cool-Rain-Calm"
  "Cool-Rain-Windy"
  "Freezing-Dry-Breeze"
  "Freezing-Dry-Calm"
  "Freezing-Dry-Windy"
  "Freezing-Rain-Breeze"
  "Freezing-Rain-Calm"
  "Freezing-Rain-Windy"
  "Hot-Dry-Breeze"
  "Hot-Dry-Calm"
  "Hot-Dry-Windy"
  "Hot-Rain-Breeze"
  "Hot-Rain-Calm"
  "Hot-Rain-Windy"
  "Warm-Dry-Breeze"
  "Warm-Dry-Calm"
  "Warm-Dry-Windy"
  "Warm-Rain-Breeze"
  "Warm-Rain-Calm"
  "Warm-Rain-Windy"
)

mkdir -p kv-data

for key in "${keys[@]}"; do
  echo "Downloading $key ..."
  curl -s "https://www.scalemates.com/api/kv.php?key=$key" -o "kv-data/${key}.html"
done

echo "Renaming files to lowercase..."
for f in kv-data/*; do
  mv "$f" "$(dirname "$f")/$(basename "$f" | tr '[:upper:]' '[:lower:]')"
done

echo "✅ Done! All files saved as *.html"