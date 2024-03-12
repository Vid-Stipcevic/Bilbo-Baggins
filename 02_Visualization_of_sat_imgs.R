# Visualization of satellite imagery with R by imageRy

library(imageRy)

# all imageRy commands start with "im."
im.list() # displays the list of available data
im.import() #imports data from the list
# example:
mato<-im.import("matogrosso_ast_2006209_lrg.jpg")
