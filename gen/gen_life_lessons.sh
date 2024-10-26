#!/usr/bin/env bash

echo -e "---\ntitle: Index of Life Lessons\n---\n"

echo -e "_This is a listing of all the life lessons portrayed in the stories of this book and the corresponding story title. It is hoped that this listing will help the reader find the story they are looking for more quickly. The numbers refer to the numbers in the story titles in the collection of digital files that accompany this book._\n"

echo "| Life Lesson | Title |"
echo "|---|---|"

for i in $(find md -maxdepth 1 -name "*.md" -printf '%f\n'); do
  (
    title=$(sed -nE 's/^title: "?([^"]+)"?$/\1/p' "md/$i")
    lesson=$(sed -nE 's/^lesson: "?([^"]+)"?$/\1/p' "md/$i")
    filename="${i%.*}"

    [ -n "$lesson" ] && echo "$lesson" | tr ";" "\n" | xargs -I {} -d'\n' printf "| {} | [$title](/stories/${filename}.html) |\n"
  ) &
done

wait
