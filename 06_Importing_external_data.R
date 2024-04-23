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

soil<-rast("weather_data_test.nc")
plot(soil)
plot(soil[[1]]) # for only the first plot

# Crop data:

ext<-c(25,30,55,59) # Sets the crop coordinates in the order : X1, X2, Y1, Y2 (from X1 to X2, and from Y1 to Y2)
soilcrop<-crop(soil,ext)
plot(soilcrop)
