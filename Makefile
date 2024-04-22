SHELL := $(shell which bash)
CV_FILENAME ?= cv

clr_error := $(shell tty -s > /dev/null 2>&1 && tput setaf 1)
clr_comment := $(shell tty -s > /dev/null 2>&1 && tput setaf 2)
clr_info := $(shell tty -s > /dev/null 2>&1 && tput setaf 3)
clr_reset := $(shell tty -s > /dev/null 2>&1 && tput sgr0)

root_dir := $(shell dirname "$(realpath $(firstword $(MAKEFILE_LIST)))")
templates_dir := $(root_dir)/templates
output_dir := $(root_dir)/output

define help
$(clr_info)Usage:$(clr_reset)
    make [target]

$(clr_info)Targets:$(clr_reset)
    clean   $(clr_comment)Remove previously generated CVs (if any)$(clr_reset)
    cv      $(clr_comment)Generate CVs in all supported formats$(clr_reset)
    cv-pdf  $(clr_comment)Generate CV in PDF format$(clr_reset)
    cv-md   $(clr_comment)Generate CV in Markdown format$(clr_reset)
    cv-html $(clr_comment)Generate CV in HTML format$(clr_reset)
endef

define render
	jinja2 --strict --extension jinja2_markdown.MarkdownExtension "$(templates_dir)/$(1)" "$(root_dir)/profile.yml"
endef

"$(output_dir)":
	@mkdir -p "$(output_dir)"

.PHONY: help
help:
	@echo $(info $(help))

.PHONY: clean
clean:
	@rm -fv "$(output_dir)"/*

.PHONY: cv
cv: | "$(output_dir)" cv-pdf cv-md cv-html

.PHONY: cv-pdf
cv-pdf:
	@$(call render,pdf.override.tex) > "$(root_dir)/.pdf.override.tex"
	@$(call render,cv.md) | SOURCE_DATE_EPOCH=0 pandoc -o "$(output_dir)/$(CV_FILENAME).pdf" \
		--pdf-engine=xelatex \
		--include-in-header="$(root_dir)/.pdf.override.tex" \
		-V mainfont="DejaVu Serif" \
		-V sansfont="DejaVu Sans" \
		-V monofont="DejaVu Sans Mono" \
		-V documentclass:scrartcl \
		-V geometry:a4paper \
		-V geometry:margin=1cm \
		-V colorlinks=true \
		-V linkcolor=blue
	@rm -f "$(root_dir)/.pdf.override.tex"

.PHONY: cv-md
cv-md: "$(output_dir)"
	@$(call render,cv.md) > "$(output_dir)/$(CV_FILENAME).md"

.PHONY: cv-html
cv-html: "$(output_dir)"
	@$(call render,cv.html) > "$(output_dir)/$(CV_FILENAME).html"
