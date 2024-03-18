# Visualization of satellite imagery with R by imageRy

library(imageRy)
library(terra))

# all imageRy commands start with "im."
im.list() # displays the list of available data
im.import() #imports data from the list
# example:
mato<-im.import("matogrosso_ast_2006209_lrg.jpg")

b2<-im.import("sentinel.dolomites.b2.tif")
b4<-im.import("sentinel.dolomites.b4.tif")
b3<-im.import("sentinel.dolomites.b3.tif")
b8<-im.import("sentinel.dolomites.b8.tif")

# Plot with 4 slots:
par(mfrow=c(2,2))
# Or:
stacksent<-c(b2,b3,b4,b8)
plot(stacksent)

dev.off() # To remove the present plot

# RGB plotting:
#slot[[1]]=b2=blue
#slot[[2]]=b3=green
#slot[[3]]=b4=red
#slot[[4]]=b8=nir
