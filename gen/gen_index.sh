#!/usr/bin/env bash

file="---\ntitle: All Stories\n---\n"

for i in md/*.md; do
  title=$(sed -nE 's/^title: "?(.*)("?)$/\1/p' "$i")
  no_ext=$(basename "$i" .md)
  file+="\n- [$title](/stories/${no_ext}.html)"
done

echo -e "$file"
