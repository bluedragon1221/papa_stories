#!/usr/bin/env bash

echo -e "---\ntitle: All Stories\n---\n"

for i in $(find md -maxdepth 1 -name "*.md" -printf '%f\n'); do
  (
    title=$(sed -n 's/^title: //p' "md/$i")
    filename="${i%.*}"
    nr="${filename%%_*}"
    printf "%s. [$title](/stories/${filename}.html)\n" "${filename%%_*}"
  ) &
done | sort -n
