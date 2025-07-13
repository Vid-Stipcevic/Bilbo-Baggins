# Multivariate Analysis: 

# Hyperspectral images: systems with hundreds of bands.
# If we have two correlated bands that each explain 50% of the data, we can exploit the principal components
# by passing two axes between the point cloud so that 90% of the points are explained by PC1 and 10% by PC2.
# Having an original set with two correlated bands, instead of using the original axes, we use new axes that represent the Principal Components
# so that the first of these has the greatest representation of the data.

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

pairs(sentdo) # Function for calculating correlation using the Pearson method.
# There is a high correlation between the blue, green, and red bands (0.99 in a range from -1 (negative correlation) to 1 (positive correlation).
# The diagonal and green images show the correlations between the bands. Red, green, and blue are correlated with each other; the NIR has a lower correlation with the other bands.

# pca

pcimage<-im.pca(sentdo) # the first string indicates the variability of each band

tot<-sum(1463.82589, 570.28864, 44.84740, 29.57957)
tot
1463.82589*100/tot # Percentage of component range variance explained; 69.42362 %
570.28864*100/tot # 27.04659 %
44.84740*100/tot # 2.126939 %
29.57957*100/tot # 1.402845 %

vir<-colorRampPalette(viridis(7))(100)
plot(pcimage, col=vir)
