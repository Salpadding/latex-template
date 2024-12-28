all:
	xelatex main.tex

fc-list:
	@fc-list :lang=zh

watch:
	which fswatch || brew install fswatch
	fswatch main.tex main.bib | while read -r file; do \
		make main.pdf; done

wc:
	@sed -En '/^[^\%]/p' main.tex | grep -oP "[\p{Han}]" | grep -Ev '。|,|，|\.'  | wc -l


%.pdf: %.tex %.bib
	xelatex $*.tex
	bibtex $*
	xelatex $*.tex
	xelatex $*.tex

%.docx: %.tex %.bib
	pandoc $*.tex --bibliography=$*.bib -o $@

.PHONY: FORCE
