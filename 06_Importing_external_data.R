# Importing data from external sources:

install.packages("RNetCDF")

library(RNetCDF)
library(imageRy)
library(terra)

setwd() # Sets a working directory
setwd("C:/Users/vidst/Downloads") # Note: transform the backlashes "\" into slashes "/"

eclissi<-rast("eclissi.png")
im.plotRGB(eclissi,1,2,3)
















