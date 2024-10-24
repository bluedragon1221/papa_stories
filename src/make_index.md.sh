#!/usr/bin/env bash

links="---
title: All Stories
---

"

for i in md/*.md; do
  title=$(grep '^title:' $i | tr -d '"' | sed -E 's/^title: (.*)$/\1/')

  no_ext=$(basename "${i%.*}")
  link="- [$title](/stories/${no_ext}.html)
"

  links+="$link"
done

echo "$links"
