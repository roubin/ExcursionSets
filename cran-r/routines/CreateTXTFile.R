CreateTXTFile<-function(RF, n_rea, T, dim){
  library('pracma')
  #FileName <- paste(folder, '/' , RFName, ".txt", sep="")

  if(dim==2) { ## 2D
    size_rf_tensor=size(size(RF))[2]
    if(size_rf_tensor==2) {
      n_rea <- 1
      RF_PRINT <- as.vector(RF)
    }
    else {
      n_rea <- size(RF)[3]
      RF_PRINT <- as.vector(RF[,,1])
      for (i in 2:n_rea)
        RF_PRINT <- cbind(RF_PRINT, as.vector(RF[,,i]))
    }  
    myFile <- file(FileName, open = "w")
    write(c(size, dim), file=myFile, ncolumns=2, sep=',')
    write(t(RF_PRINT), file = myFile, ncolumns = n_rea, append = FALSE, sep = ",")
    close(myFile)
  } else if(dim==3) { ## 3D
    N <- size(RF)
    print(N)
    Nx <- N[1]
    Ny <- N[2]
    Nz <- N[3]
    Tx <- T[1]
    Ty <- T[2]
    Tz <- T[3]

    RFName <- paste("RF_Tx",Tx,sep="")
    RFName <- paste(RFName,Ty,sep="_Ty")
    RFName <- paste(RFName,Tz,sep="_Tz")
    #FILE NAME
    FileName <- paste(RFName, ".txt", sep="")
    print(FileName)
    
    size_rf_tensor=size(size(RF))[2]
    if(size_rf_tensor==3) {
      n_rea <- 1
      RF_PRINT <- as.vector(RF)
    }
    else {
      n_rea <- size(RF)[4]
      RF_PRINT <- as.vector(RF[,,,1])
      for (i in 2:n_rea)
        RF_PRINT <- cbind(RF_PRINT, as.vector(RF[,,,i]))
    }
    myFile <- file(FileName, open = "w")
    write(c(Tx,Ty,Tz,Nx,Ny,Nz,dim), file=myFile, ncolumns=7, sep=',')
    write(t(RF_PRINT), file = myFile, ncolumns = n_rea, append = FALSE, sep = ",")
    close(myFile)
  }

}
