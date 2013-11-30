CreateDATFile<-function(RF,T){
library('pracma')
#RANDOM FIELD NAME
	RFName <- paste("RF_T",T,sep="")
#FILE NAME
	FileName <- paste(RFName, ".dat", sep="")
#RANDOM FIELD SIZE 1D
	N <- length(RF[1,1,])
	Ny <- N
	Nz <- N
	a <- seq(0,T,T/(N-1))
	b <- t(repmat(a,1,N))
	c <- t(repmat(a,1,N**2))
	coord <- cbind(c, t(repmat(sort(b),1,N)), sort(c))

	myFile <- file(FileName, open = "w")
	
	write(t(coord), file = myFile, ncolumns = 3, append = FALSE, sep = ",")
	text <- paste("FIELD\n")
	cat(text, file = myFile)
	write(RF, file = myFile, ncolumns = 1, append = FALSE, sep = "\t")

	close(myFile)
}
