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

.PHONY: help
help:
	@echo $(info $(help))

"$(output_dir)":
	@mkdir -p "$(output_dir)"

.PHONY: clean
clean:
	@rm -fv "$(output_dir)"/*

.PHONY: cv
cv: | "$(output_dir)" cv-pdf cv-md cv-html

.PHONY: cv-pdf
cv-pdf:
	@jinja2 --strict "$(templates_dir)/pdf.override.tex" "$(root_dir)/profile.yml" > "$(root_dir)/.pdf.override.tex" && \
	jinja2 --strict "$(templates_dir)/cv.md" "$(root_dir)/profile.yml" | pandoc -o "$(output_dir)/$(CV_FILENAME).pdf" \
	    --pdf-engine=pdflatex \
	    --include-before-body="$(root_dir)/.pdf.override.tex" \
	    -V geometry:a4paper \
	    -V geometry:margin=1cm \
	    -V colorlinks=true \
	    -V linkcolor=blue
	@rm -f "$(root_dir)/.pdf.override.tex"

.PHONY: cv-md
cv-md: "$(output_dir)"
	@jinja2 --strict "$(templates_dir)/cv.md" "$(root_dir)/profile.yml" > "$(output_dir)/$(CV_FILENAME).md"

.PHONY: cv-html
cv-html: "$(output_dir)"
	@jinja2 --strict "$(templates_dir)/cv.html" "$(root_dir)/profile.yml" > "$(output_dir)/$(CV_FILENAME).html"
