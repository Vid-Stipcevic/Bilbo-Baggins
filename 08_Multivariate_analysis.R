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

# 



