# STRUCTURE
This document outlines the basic structure of the repository.
I will be outlining it in a repo-agnostic manner, so you could treat this kind of like a guide to set up a similar blog-like website.

## Markdown files
all markdown files live in `md/`.
They all have frontmatter with at least a `title`, however I also utilize frontmatter for other features of the site

Images are stored really anywhere in the `md/` directory, as long as pandoc can find them up when building.

At compile time, pandoc picks up all of these markdown files and puts them in `${BUILD_DIR}/stories`.
Some notable pandoc settings:
- `--embed-resources`: This is because I don't want to bother with images in the final build, so I just have pandoc build them into the markdown files.
  As a side benefit, this means that one html file can be used independently and it will contain all of the styling, images, etc for the page.

- `--template template.html`: This puts the pandoc output into a little template I made.
  In the template, I only have some css, a title line, and a link back to the homepage, but I could see this growing in the future.

## Generation Scripts
I have a few scripts living in `gen/`.
These scripts all output valid markdown, which is then parsed by pandoc and placed in the appropriate location.

It determines where the files go based on the file name.
- `gen/gen_index.md` => `build/index.html`
- `gen/gen_life_lessons.md` => `build/life_lessons.html`
You get the idea.

### Example
For an example of a script, lets go through a simplified version of `gen_index.sh`.
The index page has a link to every markdown file, so it's very important.

```
#!/usr/bin/env bash
echo "---"
echo "title: All Stories"
echo "---"
echo

for i in md/*.md; do
  title=$(grep "^title: " "$i" | sed -E 's/^title: (.*)/\1/')
  dest="/stories/$(basename "$i" .md).html"
  echo "- [$title]($dest)"
done
```

First, we print some frontmatter to establish a title.

Next, we iterate through the `md/` directory, finding all of the markdown files.
We extract the title from the frontmatter using `sed`, and establish where we want the link to point.
After printing it in the markdown link format, the script is done.

When building the project, `make` runs this script, converts the output to html, and puts it in the `$BUILD_DIR`
