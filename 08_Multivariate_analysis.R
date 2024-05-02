# Multivariate Analysis: 

library(terra)
library(imageRy)
library(viridis)

im.list()
b2<-im.import("sentinel.dolomites.b2.tif") # Blue
b3<-im.import("sentinel.dolomites.b3.tif") # Green
b4<-im.import("sentinel.dolomites.b4.tif") # Red
b8<-im.import("sentinel.dolomites.b8.tif") # NIR
sentdo<-c(b2,b3,b4,b8)
im.plotRGB(sentdo,r=4,g=3,b=2)

# Measuring the data correlation

pairs(sentdo)

# pca

pcimage<-im.pca(sentdo)

tot<-sum(1463.82589, 570.28864, 44.84740, 29.57957)
tot
1463.82589*100/tot # Percentage of component range variance explained

vir<-colorRampPalette(viridis(7))(100)
plot(pcimage, col=vir)
