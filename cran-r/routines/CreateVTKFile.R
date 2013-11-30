CreateVTKFile<-function(RF,T,dim){
library('pracma')
#RANDOM FIELD NAME
	RFName <- paste("RF_T",T,sep="")
#FILE NAME
	FileName <- paste(RFName, ".vtk", sep="")
#RANDOM FIELD SIZE 1D
	if ( dim == 1 ) {
		N <- length(RF)
		Ny <- 1
		Nz <- 1
		a <- seq(0,T,T/(N-1))
		coord <- cbind(a, 0.0*a, 0.0*a)
	}
	else if ( dim == 2 ) {
		N <- length(RF[1,])
		Ny <- N
		Nz <- 1
		a <- seq(0,T,T/(N-1))
		b <- t(repmat(a,1,N))
		coord <- cbind(b, sort(b), 0.0*a)
	}
	else {
		N <- length(RF[1,1,])
		Ny <- N
		Nz <- N
		a <- seq(0,T,T/(N-1))
		b <- t(repmat(a,1,N))
		c <- t(repmat(a,1,N**2))
		coord <- cbind(c, t(repmat(sort(b),1,N)), sort(c))
	}

	myFile <- file(FileName, open = "w")
	
	text <- "# vtk DataFile Version 2.0\n"
	cat(text, file = myFile)
	text <- paste(RFName, "\n")
	cat(text, file = myFile)
	text <- "ASCII\nDATASET STRUCTURED_GRID\n"
	cat(text, file = myFile)
	text <- paste("DIMENSIONS", N, Ny, Nz, "\n")
	cat(text, file = myFile)
	text <- paste("POINTS", N**dim, "float\n")
	cat(text, file = myFile)
	write(t(coord), file = myFile, ncolumns = 3, append = FALSE, sep = "\t")
	text <- paste("\nPOINT_DATA", N**dim, "\n")
	cat(text, file = myFile)
	text <- paste("SCALARS", RFName, "float 1\n")
	cat(text, file = myFile)
	text <- "LOOKUP_TABLE default\n"
	cat(text, file = myFile)
	write(RF, file = myFile, ncolumns = 1, append = FALSE, sep = "\t")

	close(myFile)

}
