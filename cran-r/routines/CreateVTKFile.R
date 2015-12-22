CreateVTKFile<-function(RF,T,dim, RFName){
library('pracma')

#RANDOM FIELD NAME
	#RFName <- paste("RF_T",T,sep="")
#FILE NAME
	FileName <- paste(RFName, ".vtk", sep=" ")
	print(paste('Writing VTK file', FileName, sep=""))
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
		N <- size(RF)
		print(N)
		Nx <- N[1]
		Ny <- N[2]
		Nz <- N[3]
		Tx <- T[1]
		Ty <- T[2]
		Tz <- T[3]
		x <- seq(0,Tx,Tx/(Nx-1))
		y <- seq(0,Ty,Ty/(Ny-1))
		z <- seq(0,Tz,Tz/(Nz-1))
		
		a <- t(repmat(x,1,Ny*Nz))
		b <- t(repmat(sort(t(repmat(y,1,Nx))),1,Nz))
		c <- sort(b)
		coord <- cbind(a,b,c)

		#RFName <- paste("RF_Tx",Tx,sep="")
		#RFName <- paste(RFName,Ty,sep="_Ty")
		#RFName <- paste(RFName,Tz,sep="_Tz")
		#FILE NAME
		FileName <- paste(RFName, ".vtk", sep="")

	}

	myFile <- file(FileName, open = "w")
	
	text <- "# vtk DataFile Version 2.0\n"
	cat(text, file = myFile)
	text <- paste(RFName, "\n")
	cat(text, file = myFile)
	text <- "ASCII\nDATASET STRUCTURED_GRID\n"
	cat(text, file = myFile)
	text <- paste("DIMENSIONS", Nx, Ny, Nz, "\n")
	cat(text, file = myFile)
	text <- paste("POINTS", Nx*Ny*Nz, "float\n")
	cat(text, file = myFile)
	write(t(coord), file = myFile, ncolumns = 3, append = FALSE, sep = "\t")
	text <- paste("\nPOINT_DATA", Nx*Ny*Nz, "\n")
	cat(text, file = myFile)
	text <- paste("SCALARS", RFName, "float 1\n")
	cat(text, file = myFile)
	text <- "LOOKUP_TABLE default\n"
	cat(text, file = myFile)
	write(RF, file = myFile, ncolumns = 1, append = FALSE, sep = "\t")

	close(myFile)
	
	print('done')

}
