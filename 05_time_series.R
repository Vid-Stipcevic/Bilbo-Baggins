#   Another method of classification

library(imageRy)
library(terra)

par(mfrow=c(1,2))
EN01<-im.import("EN_01.png")
EN13<-im.import("EN_13.png")
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

# Plotting the difference of two imagess:

difEN = EN01[[1]] - EN13[[1]]
cl<-colorRampPalette(c("blue","white","red"))(100)
plot(difEN, col=cl)

# Ice melt in Greenland:

gr2000<-im.import("greenland.2000.tif")
gr2005<-im.import("greenland.2005.tif")
gr2010<-im.import("greenland.2010.tif")
gr2015<-im.import("greenland.2015.tif")
clg<-colorRampPalette(c("black","blue","white","red"))(100)

par(mfrow=c(2,2))
plot(gr2000, col=clg)
plot(gr2005, col=clg)
plot(gr2010, col=clg)
plot(gr2015, col=clg)

# or;

greenland<-c(gr2000,gr2005,gr2010,gr2015)

difgr=greenland[[4]]-greenland[[1]]

# RGB plot (gr2000 on red, gr2005 on green, gr2015 on blue):

im.plotRGB(greenland, 1, 2, 4)


























