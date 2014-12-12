CreateTXTFile<-function(RF, n_rea, T, dim, folder, RFName){
  library('pracma')
  FileName <- paste(folder, '/' , RFName, ".txt", sep="")

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
    write(c(size, dim), file=myFile, ncolumns=2, sep=',')
    write(t(RF_PRINT), file = myFile, ncolumns = n_rea, append = FALSE, sep = ",")
    close(myFile)
  }

}
