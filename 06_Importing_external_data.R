# Importing data from external sources:

install.packages("RNetCDF")

library(RNetCDF)
library(imageRy)
library(terra)

# Example of image sources: "https://github.com/ducciorocchini/telerilevamento2024/blob/main/Code/07_data_sources.md"

setwd() # Sets a working directory
setwd("C:/Users/.../Downloads") # Note: transform the backlashes "\" into slashes "/"

eclissi<-rast("eclissi.png")
im.plotRGB(eclissi,1,2,3)

dif=eclissi[[1]]-eclissi[[2]]
plot(dif)














