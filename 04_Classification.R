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











