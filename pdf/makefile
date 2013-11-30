texname=Handbook
#texsrc=/usr/texbin/
#gssrc=/usr/local/bin/
texsrc=''
gssrc=''


all:
	@${texsrc}latex  ${texname}.tex
	@${texsrc}latex  ${texname}.tex
	@${texsrc}dvips -q ${texname}.dvi
	@${gssrc}ps2pdf ${texname}.ps
	@make clean


clean:
	@rm -fv ${texname}.aux
	@rm -fv ${texname}.log
	@rm -fv ${texname}.toc
	@rm -fv ${texname}.ps
	@rm -fv ${texname}.dvi
	@rm -fv *~
