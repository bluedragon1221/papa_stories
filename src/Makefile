BUILD_DIR ?= build

MARKDOWNFILES = $(wildcard md/*.md)
HTMLTARGETS = $(MARKDOWNFILES:md/%.md=$(BUILD_DIR)/stories/%.html)

$(BUILD_DIR)/stories $(BUILD_DIR):
	mkdir -p $@

$(BUILD_DIR)/stories/%.html: md/%.md | $(BUILD_DIR)/stories
	pandoc "$<" \
		--standalone \
		--embed-resources \
		--template template.html \
		-o "$@"

$(BUILD_DIR)/index.html: gen/gen_index.sh | $(BUILD_DIR)
	bash $< | pandoc \
		--standalone \
		--embed-resources \
		--template template.html \
		-o "$@"

all: make_dirs $(HTMLTARGETS) $(BUILD_DIR)/index.html

.PHONY: make_dirs all

