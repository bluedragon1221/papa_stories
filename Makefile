## Requisite directories
BUILD_DIR ?= build
$(BUILD_DIR)/stories $(BUILD_DIR):
	mkdir -p $@


## MD Files -> HTML
MARKDOWNFILES := $(wildcard md/*.md)
HTMLTARGETS := $(MARKDOWNFILES:md/%.md=$(BUILD_DIR)/stories/%.html)

$(BUILD_DIR)/stories/%.html: md/%.md | $(BUILD_DIR)/stories
	pandoc "$<" \
		--standalone \
		--embed-resources \
		--template template.html \
		-o "$@"


## Shell Script -> MD Files -> HTML
GENFILES := $(wildcard gen/gen_*.sh)
GENTARGETS := $(GENFILES:gen/gen_%.sh=$(BUILD_DIR)/%.html)

$(BUILD_DIR)/%.html: gen/gen_%.sh | $(BUILD_DIR)
	bash $< | pandoc \
		--standalone \
		--embed-resources \
		--template template.html \
		-o "$@"


all: $(HTMLTARGETS) $(GENTARGETS)
.PHONY: all
