#   Quantification of land cover change

install.packages("ggplot2")

library(terra)
library(imageRy)
library(ggplot2)

sun<-im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# Image classification:

sunc<-im.classify(sun, num_clusters = 3)

m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg")

m1992c<-im.classify(m1992, num_clusters = 2)

# m1992 : class 1 = human, class 2 = forest

m2006c<-im.classify(m2006, num_clusters = 2)

# m2006 : class 1 = forest, class 2 = human

# Pixel frequencies:

f1992<-freq(m1992c)
f2006<-freq(m2006c)

# Proportions:

tot1992<-ncell(m1992c)
tot2006<-ncell(m2006c)

prop1992<-f1992/tot1992
prop2006<-f2006/tot2006

# Percentages:

perc1992<-prop1992*100   # 17% human, 83% forest
perc2006<-prop2006*100   # 55% human, 45% forest

# Graph creation:

class<-c("forest","human")
y1992<-c(83,17)
y2006<-c(45,55)

tabout<-data.frame(class,y1992,y2006)
View(tabout)

ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")

install.packages("patchwork")
library(patchwork)

p1<-ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p2<-ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")

p1+p2

p1<-ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(0,100)
p2<-ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(0,100)
p1+p2
























