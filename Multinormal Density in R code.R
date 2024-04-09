### title: "Multinormal Density in R code"
### author: "AngeloPStats"
### date: "2022-04-05"

## ***Let's start by downloading two main packages in R Studio***

## *Plots 3D*

library(plot3D)

library(mvtnorm)

## *Now, to set up our grid-2D we can create a range of values of x1 and x2*

x1 = seq(-pi/4, pi/4, len=30)

x2 = seq(pi/4,3*pi/4, len=30)

## *This is because the normal density varies from -3 to 3, approximately*

## *The next step is to form two 2D functions to get a 3D plot*

f.function = function(x1,x2){cos(x1*x2)}

h.function = function(x1,x2){1-((pi*x1)^2)/8}

## *Now we can use "persp3D" and "outer". *

## *They are part of the previously downloaded package*
  
## **Plot in 3D**

zf.function = outer(x1,x2,f.function )

zh.function = outer(x1,x2,h.function )


## *This is to organize the plots in a matrix view*

par(mfrow = c(1,2))

## *color surface of f is red*

persp3D(x1,x2,zf.function,col = "red", main="f function surface")

persp3D(x1,x2,zh.function,col = "blue", main="h function surface")


  