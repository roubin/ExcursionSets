library('RandomFields')


RFoptions(seed=NA,spConform=FALSE)
#RFgetModelNames(type="positive definite", domain="single variable", iso="isotropic")



modelA <- RMgauss(var=1, scale=1) + RMnugget(var=0) + RMtrend(mean=0.5)
modelB <- RMgauss(var=1, scale=3) + RMnugget(var=0) + RMtrend(mean=0.5)
modelC <- RMgauss(var=1, scale=5) + RMnugget(var=0) + RMtrend(mean=0.5)


size <- c(57,57,57)
step=10.285
x <- seq(0, size[1], step)
y <- seq(0, size[2], step)
z <- seq(0, size[3], step)

#simuA <- RFsimulate(modelA, x=x.seq, y=y.seq, z=z.seq, grid=NULL)
simuB <- RFsimulate(modelB, x=x, y=y, z=z, grid=NULL)
#simuC <- RFsimulate(modelC, x=x.seq, y=y.seq, z=z.seq, grid=NULL)

#simu = pmax(simuA, simuB, simuC)

source("/Users/roubin/Sites/ExcursionSets/cran-r/routines/CreateVTKFile.R")
dimension <- 3
#CreateVTKFile(simuA,size,dimension, 'A')
#CreateVTKFile(simuB,size,dimension, '57')
#CreateVTKFile(simuC,size,dimension, 'C')
