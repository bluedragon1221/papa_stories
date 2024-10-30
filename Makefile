## Requisite directories
BUILD_DIR ?= build
$(BUILD_DIR)/stories $(BUILD_DIR):
	mkdir -p $@


## MD Files -> HTML
MARKDOWNFILES := $(wildcard md/*.md)
HTMLTARGETS := $(patsubst md/%.md, $(BUILD_DIR)/stories/%.html, $(MARKDOWNFILES))

$(BUILD_DIR)/stories/%.html:: md/%.md | $(BUILD_DIR)/stories
	pandoc "$<" \
		--standalone \
		--embed-resources \
		--toc \
		--template template.html \
		-o "$@"


## Shell Script -> MD Files -> HTML
GENFILES := $(wildcard gen/gen_*.sh)
GENTARGETS := $(patsubst gen/gen_%.sh, $(BUILD_DIR)/%.html, $(GENFILES))

$(BUILD_DIR)/%.html:: gen/gen_%.sh | $(BUILD_DIR)
	bash $< | pandoc \
		--standalone \
		--embed-resources \
		--template template.html \
		-o "$@"


all: $(HTMLTARGETS) $(GENTARGETS)
.PHONY: all
.DEFAULT_GOAL := all

clean:
	rm -rf $(BUILD_DIR)
.PHONY: clean
