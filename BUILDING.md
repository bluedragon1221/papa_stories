# Building this Project

For a quick-and-dirty build, just run `make all`.
To specify the directory to build into, you can pass in BUILD_DIR, e.g. `make BUILD_DIR=../_build all`.

Although the project is quite fast to build, we support [parallel execution](https://www.gnu.org/software/make/manual/html_node/Parallel.html).
This means you can pass the `-j` flag followed by the number of cores to compile markdown files in parallel.

## Git Build (for maintainers)
This is my general process:
```bash
export BUILD_DIR=$(mktemp -d)
make all

git checkout build
cp -r $BUILD_DIR/* .

git add .
git commit -m "build: $(date)"
git push

unset BUILD_DIR
```

_(CI/CD is scary, so I avoid it)_
