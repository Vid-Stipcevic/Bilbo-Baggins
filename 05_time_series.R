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
















