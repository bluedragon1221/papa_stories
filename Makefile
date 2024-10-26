BUILD_DIR ?= build

MARKDOWNFILES = $(wildcard md/*.md)
HTMLTARGETS = $(MARKDOWNFILES:md/%.md=$(BUILD_DIR)/stories/%.html)

GENFILES = $(wildcard gen/gen_*.sh)
GENTARGETS = $(GENFILES:gen/gen_%.sh=$(BUILD_DIR)/%.html)

$(BUILD_DIR)/stories $(BUILD_DIR): ## Requisite folders
	mkdir -p $@

$(BUILD_DIR)/stories/%.html: md/%.md | $(BUILD_DIR)/stories ## MD Files -> HTML
	pandoc "$<" \
		--standalone \
		--embed-resources \
		--template template.html \
		-o "$@"

$(BUILD_DIR)/%.html: gen/gen_%.sh | $(BUILD_DIR) ## Shell Script -> MD Files -> HTML
	bash $< | pandoc \
		--standalone \
		--embed-resources \
		--template template.html \
		-o "$@"

all: $(HTMLTARGETS) $(GENTARGETS)
.PHONY: all
