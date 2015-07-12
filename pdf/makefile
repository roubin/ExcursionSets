name=Handbook


ifeq ($(shell uname), Darwin)
	texsrc=/usr/texbin/
	gssrc=/usr/local/bin/
else
	texsrc=''
	gssrc=''
endif


all:
	@${texsrc}latex ${name}.tex
	@make pdf

FULL:
	@make clean
	@make ref
	@make pdf
	@make clean

pdf:
	@${texsrc}dvips ${name}.dvi
	@${gssrc}ps2pdf ${name}.ps

ref:
	@${texsrc}latex ${name}.tex
#	@${texsrc}bibtex ${name}
#	@${texsrc}latex ${name}.tex
	@${texsrc}latex ${name}.tex
	@${texsrc}latex ${name}.tex

clean:
	@rm -fv ${name}.tns
	@rm -fv ${name}.ps
	@rm -fv ${name}.odt
	@rm -fv ${name}.log
	@rm -fv ${name}.dvi
	@rm -fv ${name}.aux
	@rm -fv ${name}.bbl
	@rm -fv ${name}.blg
	@rm -fv ${name}.out
	@rm -fv ${name}.toc
	@rm -fv *~

erase:
	@make clean
	@rm -fv ${name}.pdf
