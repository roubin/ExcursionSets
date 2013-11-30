#load library
library('RandomFields')

# Parameters
n_rea = 10

size = 100
step = 0.1

mean = 0.0
variance = 2
nugget = 0
scale = 0.5

method='circulant embeded'
model = "stable"
# 0 < alpha < 2
#alpha = 1 # exp(-h)
alpha = 2 #exp(-h^2)
param = c(mean, variance, nugget, scale, alpha)

x = seq(0, size, step)
RF = GaussRF(method=method, x=x, n=n_rea, model=model, grid=TRUE, param=param)

#myFile = file("gaussian_random_field_1D.dat", open="w")
#write(x, file=myFile, ncolumns=1, append=FALSE)
#write('FIELD', file=myFile)
#write(RF, file=myFile, ncolumns=n_rea, sep=',', append=FALSE)
#close(myFile)

myFile = file("./output/gaussian_random_field_1D.txt", open="w")
write(c(size, '1'), file=myFile, ncolumns=2, sep=',')
write(t(RF),file=myFile, ncolumns=n_rea, sep=',', append=FALSE)
close(myFile)

