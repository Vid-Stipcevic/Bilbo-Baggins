# Measuring variability from satellite imagery

install.packages("viridis")

library(terra)
library(imageRy)
library(viridis)

sentinel<-im.import("sentinel.png")
im.plotRGB(sentinel,1,2,3) # NIR = band 1, red = band 2, green = band 3

nir<-sentinel[[1]]
cl<-colorRampPalette(c("black","blue","green","yellow"))(100)
plot(nir,col=cl)

# Calculate focal ("moving window"):

sd3<-focal(nir, matrix(1/9, 3, 3), fun=sd)
viridisc<-colorRampPalette(viridis(7))(256)
plot(sd3,col=viridisc)

sd7<-focal(nir, matrix(1/49, 7, 7), fun=sd) # Standard deviation 7x7
stacksd<-c(sd3,sd7)
plot(stacksd,col=viridisc)
