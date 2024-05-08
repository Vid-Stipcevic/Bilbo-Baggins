# Commands to receive 3217833:
a<-14*229845
b<-2+1
a+b

# Arrays, or in other words flowers and insects <3
flowers<-c(3, 6, 8, 10, 15, 18)
flowers
insects<-c(10, 16, 25, 42, 61, 73)
insects

# Plots (X, Y, Symbol type, Symbol size, Symbol color)
plot(flowers, insects, pch=8, cex=4, col="darkgreen")

# Install new packages
install.packages("")

# List of installed Packages
packlist<-as.data.frame(installed.packages()[,c(1,3:4)])
packlist<-packlist[is.na(packlist$Priority),1:2,drop=FALSE]
packlist

# Load package:
library()

#es.
install.packages("devtools")
library(devtools)

# es. Installing a package from Github, devtools package required
install_github("ducciorocchini/imageRy")
library(imageRy)


