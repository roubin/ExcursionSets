#load library
library('RandomFields')

dim <- 3
n_rea <- 1


step <- 1

mean <- 0.0
variance <- 2
nugget <- 0
scale <- 2


method='circulant embeded'
model <- "stable"
# 0 < alpha < 2
#alpha = 1 # exp(-h)
alpha = 2 #exp(-h^2)
param <- c(mean, variance, nugget, scale, alpha)

#method <- 'circulant embeded'
#model <- "matern"
#p <- 2
#nu <- p+1.0/2.0
#nu <- 2.0
#param <- c(mean, variance, nugget, scale, nu)

size <- c(100,100,100)
x <- seq(0, size[1], step) 
y <- seq(0, size[2], step) 
z <- seq(0, size[3], step) 

RF <- GaussRF(method=method, x=x, y=y, z=z, n=n_rea, model=model, grid=TRUE, param=param)

#setEPS()
#postscript("output/gaussian_random_fields.eps")


#if(n_rea==1){
#  image(x, y, RF, )
#} else {
#  image(x, y, RF[,,1])
#}

#dev.off()

#print('PLOT VTK')
#source("/Users/roubin/Work/ExcursionSets/cran-r/routines/CreateVTKFile.R")
source("/home/eroubin/Work/ExcursionSets/cran-r/routines/CreateVTKFile.R")
dim <- 3
CreateVTKFile(RF,size,dim)

#print('PLOT TXT')
#source("/Users/roubin/Work/ExcursionSets/cran-r/routines/CreateTXTFile.R")
#source("/home/eroubin/Work/ExcursionSets/cran-r/routines/CreateTXTFile.R")
#CreateTXTFile(RF, n_rea, size, dim)
