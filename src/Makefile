BUILD_DIR = _build

MARKDOWNFILES != find md/ -type f -name "*.md"
HTMLTARGETS = $(MARKDOWNFILES:md/%.md=$(BUILD_DIR)/stories/%.html)

$(BUILD_DIR)/stories/%.html: md/%.md
	pandoc "$<" \
		--standalone \
		--embed-resources \
		--template template.html \
		-o "$@"

$(BUILD_DIR)/index.html: make_index.md.sh
	bash $< | pandoc \
		--standalone \
		--embed-resources \
		--template template.html \
		-o "$@"

make_dirs:
	mkdir -p $(BUILD_DIR)/stories

all: make_dirs $(HTMLTARGETS) $(BUILD_DIR)/index.html

clean:
	rm -rf $(BUILD_DIR)

.PHONY: clean make_dirs all up
