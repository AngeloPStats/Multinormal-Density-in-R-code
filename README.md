# Multinormal-Density-in-R-code
Efficient R code can plot theoretical concepts for a multivariate normal density. Below outlines the procedure.

***Download***


***Let's start by downloading two main packages in R Studio***

*Plots 3D*

    ```{r warning=FALSE}
    
    install.packages("plot3D")
    
    library(plot3D)
    
    ```


*Computes multivariate normal densities*

    ```{r warning=FALSE}
    install.packages("mvtnorm")
    
    library(mvtnorm)
    
    ```

*Now, to set up our grid-2D we can create a range of values of x1 and x2*

    ```{r warning=FALSE}
    x1 = seq(-pi/4, pi/4, len=30)
    
    x2 = seq(pi/4,3*pi/4, len=30)
    
    ```


*This is because the normal density varies from -3 to 3, approximately*

*The next step is to form two 2D functions to get a 3D plot*

    ```{r warning=FALSE}
    f.function = function(x1,x2){cos(x1*x2)}
    
    h.function = function(x1,x2){1-((pi*x1)^2)/8}
    
    ```

*Now we can use "persp3D" and "outer".*

*They are part of the previously downloaded package*

**Plot in 3D**

    ```{r warning=FALSE}
    
    zf.function = outer(x1,x2,f.function )
    
    zh.function = outer(x1,x2,h.function )
    
    ```


*This is to organize the plots in a matrix view*

    ```{r warning=FALSE}
    
    par(mfrow = c(1,2))
    
    ```

*color surface of f is red*
*color surface of h is blue*

    ```{r warning=FALSE}
    persp3D(x1,x2,zf.function,col = "red", main="f function surface")
    
    persp3D(x1,x2,zh.function,col = "blue", main="h function surface")
    
    
    ```

*.rmd linguist-language=R *

**FOR 2D**

*Here is the Theory:*

The pdf for a bi-variate 2D or (p=2) normal density at a point $x =(x_{1}, x_{2})$ is given by

$f(x) = (2\pi)^{-1} |\Sigma|^{-1/2} exp[\frac{-1}{2} (x-x_{0})^{T}\Sigma^{-1}(x-x_{0})]$

Were the second order Taylor expansion for f(x) around the point $x_0 = (x_{1}, x_{2})^T$ must have the form of

$f(x) = f(x_{0}) + (x-x_{0})^T \nabla f(x_{0}) +1/2(x-x_{0})^T \nabla^{2} f(x_{0})(x-x_{0}) + R$   

so, to find each term of Taylor expansion, we work with this equation 

$f(x) = (2\pi)^{-1} |\Sigma|^{-1/2} exp[\frac{-1}{2} (x-x_{0})^{T}\Sigma^{-1}(x-x_{0})]$

when $x_{0} = (u_{1}, u_{2}) = u$ then the Taylor expansion equation is

$f(x) = f(u) + (x-u)^T \nabla f(u) +1/2(x-u)^T \nabla f^2(u)(x-u) + R$

and our bivariate equation is 

$f(x) = (2\pi)^{-1} |\Sigma|^{-1/2} exp[\frac{-1}{2} (x-u)^{T}\Sigma^{-1}(x-u)]$

for the first term of Taylor expansion $f(x_{0}) = f(u)$

$f(u) = (2\pi)^{-1} |\Sigma|^{-1/2} exp[\frac{-1}{2} (u-u)^{T}\Sigma^{-1}(u-u)]$

$f(u) = (2\pi \sqrt{|\Sigma|})^{-1} exp[\frac{-1}{2} (0)^{T}\Sigma^{-1}(0)] = (2\pi \sqrt{|\Sigma|})^{-1}$ 

for the second term of Taylor expansion $(x-u)^T \nabla f(u)$ ; which is the

$(x-u)^T$ times the gradient of x when (x = u). But the gradient is equal to zero as

we will see below

Expanding terms from right to left:

$$\Sigma^{-1}=(\frac{1}{\sigma_{11}\sigma_{22}- \sigma_{21}^2}) \begin{bmatrix}\sigma_{22} & - \sigma_{12} \\\ - \sigma_{21} & \sigma_{11} \end{bmatrix}$$

by definition of symmetry, $\sigma_{12} = \sigma_{21}$

$$\Sigma^{-1}(x - x_{0}) = \frac{1}{\Sigma}\begin {bmatrix} \sigma_{22}(x_{1}-u_{1}) & -\sigma_{12}(x_{2} - u_{2}) \\ -\sigma_{21}(x_{1}-u_{1}) & \sigma_{11}(x_{2} - u_{2})  \end{bmatrix}$$

and

$$exp[- \frac{1}{2} (x-u)^T \Sigma^{-1}(x-u)]= exp[- \frac{1}{2} [(x_{1}-u_{1}),(x_{2} - u_{2})] \frac{1}{\Sigma}\begin {bmatrix} \sigma_{22}(x_{1}-u_{1}) & -\sigma_{12}(x_{2} - u_{2}) \\ -\sigma_{21}(x_{1}-u_{1}) & \sigma_{11}(x_{2} - u_{2})   \end{bmatrix}   ]$$

$$exp[- \frac{1}{2|\Sigma|} [\sigma_{22}(x_{1}-u_{1})^2 -2\sigma_{21}(x_{1}-u_{1})(x_{2} - u_{2}) + \sigma_{11}(x_{2} - u_{2})^2]$$

It looks like ${var(x) -2cov(xy) + var(y)}$

so our function is

$\boxed{f(x)= (2\pi \sqrt{|\Sigma|})^{-1} exp[- \frac{1}{2|\Sigma|} [\sigma_{22}(x_{1}-u_{1})^2 -2\sigma_{21}(x_{1}-u_{1})(x_{2} - u_{2}) + \sigma_{11}(x_{2} - u_{2})^2]}$

the gradient is formed by

$\nabla f(x) = [ \frac{\partial} {\partial x_{1}} , \frac{\partial} {\partial x_{2}}]$


$\frac{\partial f(x)} {\partial x_{1}}= \frac{1}{2\pi|\Sigma|^{1/2}}   [\frac{-1}{2|\Sigma|}]  [2\sigma_{22}(x_{1}-u_{1}) - 2\sigma_{21}(x_{2} - u_{2})] exp[- \frac{1}{2|\Sigma|} [\sigma_{22}(x_{1}-u_{1})^2 -2\sigma_{21}(x_{1}-u_{1})(x_{2} - u_{2}) + \sigma_{11}(x_{2} - u_{2})^2]$

If we do 

$k=[\frac{-1}{2|\Sigma|}]$

$Q(x)= [\sigma_{22}(x_{1}-u_{1})^2 -2\sigma_{21}(x_{1}-u_{1})(x_{2} - u_{2}) + \sigma_{11}(x_{2} - u_{2})^2]$

$Q^{'}(x_{1})= [2\sigma_{22}(x_{1}-u_{1}) - 2\sigma_{21}(x_{2} - u_{2})]$

$Q^{'}(x_{2})= [-2\sigma_{21}(x_{1}-u_{1}) + 2\sigma_{11}(x_{2} - u_{2})]$

then 

$\frac{\partial^{1} f(x)} {\partial x_{1}}= k f(x)Q^{'}(x_{1})$

$\frac{\partial^{1} f(x)} {\partial x_{1}}= k f(x)[2\sigma_{22}(x_{1}-u_{1}) - 2\sigma_{21}(x_{2} - u_{2})]$ 

$\frac{\partial^{1} f(x)} {\partial x_{1}}= k f(x)Q^{'}(x_{2})$

similarly for 

$\frac{\partial^{1} f(x)} {\partial x_{2}}$

$\frac{\partial^{1} f(x)} {\partial x_{2}}= k f(x)[-2\sigma_{21}(x_{1}-u_{1}) + 2\sigma_{11}(x_{2} - u_{2})]$

for x=u $(x_{1}=u_{1},x_{2}=u_{2})$   the two equations above turn to zero so

$\frac{\partial f(x)} {\partial x_{1}}=0$ and  $\frac{\partial f(x)} {\partial x_{2}}=0$

$\nabla f(x=u) =[0,0]$ and $(x-u)^T \nabla f(u) =0$

for the third term of Taylor expansion

$1/2(x-x_{0})^T \nabla^{2} f(x_{0})(x-x_{0})$

We have to find $\nabla^{2} f(x_{0})$  , so from

$\frac{\partial^{1} f(x)} {\partial x_{1}}= k f(x)Q^{'}(x_{1})$

$\frac{\partial^{2}f(x)} {\partial x_{1}\partial x_{1}}= k[f^{'}(x)Q^{'}(x_{1})+ f(x)Q^{''}(x_{1})]$

$\frac{\partial^{2} f(x)} {\partial x_{1}\partial x_{1}}= k[f(x)Q^{'}(x_{1})Q^{'}(x_{1})+ f(x)Q^{''}(x_{1})]$

$\frac{\partial^{2} f(x)} {\partial x_{1}\partial x_{1}}= k[f(x)(Q^{'}(x_{1}))^{2}+ f(x)Q^{''}(x_{1})]$

$\frac{\partial^{2} f(x)} {\partial x_{1}\partial x_{1}}= kf(x)[(Q^{'}(x_{1}))^{2}+ Q^{''}(x_{1})]$

$\frac{\partial^{2} f(x)} {\partial x_{1}\partial x_{1}}= kf(x)[k(2\sigma_{22}(x_{1}-u_{1}) - 2\sigma_{21}(x_{2} - u_{2}))^{2}+ 2\sigma_{22}]$

when $(x_{1} = u_{1})$   and  $(x_{2} = u_{2})$

$\frac{\partial^{2} f(x)} {\partial x_{1}\partial x_{1}}= kf(x)[2\sigma_{22}]$

$\frac{\partial^{2} f(x)} {\partial x_{1}\partial x_{1}}= k[\frac{1}{2\pi{|\Sigma|}^{\frac{1}{2}}}] [2\sigma_{22}]$

for $x_{2}$

$\frac{\partial^{2}f(x)} {\partial x_{2}\partial x_{2}}= k[f^{'}(x)Q^{'}(x_{2})+ f(x)Q^{''}(x_{2})]$

$\frac{\partial^{2} f(x)} {\partial x_{2}\partial x_{2}}= kf(x)[k(-2\sigma_{21}(x_{1}-u_{1})+ 2\sigma_{11}(x_{2} - u_{2}))^{2}+ 2\sigma_{11}]$

when $(x_{1} = u_{1})$   and  $(x_{2} = u_{2})$

$\frac{\partial^{2} f(x)} {\partial x_{2}\partial x_{2}}= kf(x)[2\sigma_{11}]$

$\frac{\partial^{2} f(x)} {\partial x_{2}\partial x_{2}}= k[\frac{1}{2\pi{|\Sigma|}^{\frac{1}{2}}}][2\sigma_{11}]$

Also by symmetry, 

$\frac{\partial^{2} f(x)} {\partial x_{1}\partial x_{2}}= \frac{\partial^{2} f(x)} {\partial x_{2}\partial x_{1}}= kf(x)[-2\sigma_{21}] = k [\frac{1}{2\pi{|\Sigma|}^{\frac{1}{2}}}][-2\sigma_{21}]$

$$\nabla^{2} f(x_{0})= \begin{bmatrix} \frac{\partial^2 f(x)} {\partial x_{1}\partial x_{1}} & \frac{\partial^2 f(x)} {\partial x_{1}\partial x_{2}} \\ \frac{\partial^2 f(x)}{\partial x_{2}\partial x_{1}}& \frac{\partial^2 f(x)} {\partial x_{2}\partial x_{2}} \end{bmatrix}$$

$$\nabla^{2} f(x_{0})= [\frac{-1}{2|\Sigma|}][\frac{1}{2\pi{|\Sigma|}^{\frac{1}{2}}}] \begin{bmatrix}(2\sigma_{22})& -(2\sigma_{21})\\ -(2\sigma_{21}) &(2\sigma_{11})\end{bmatrix}$$

In

$$1/2(x-x_{0})^T \nabla^{2} f(x_{0})(x-x_{0})=\frac{1}{2}\begin{bmatrix} (x_{1}- u_{1}) (x_{2}- u_{2}) \end{bmatrix} [\frac{-1}{2|\Sigma|}][\frac{1}2\pi{|\Sigma|}^{\frac{1}{2}}] \begin{bmatrix}(2\sigma_{22})& -(2\sigma_{21})\\ -(2\sigma_{21}) & (2\sigma_{11})\end{bmatrix} \begin{bmatrix} (x_{1}- u_{1})\\ (x_{2}- u_{2}) \end{bmatrix}$$

Then the second order Taylor expansion for f(x) around the point $x_0 = (x_{1}, x_{2})^T$ 

is of the form

$f(x) = f(x_{0}) + (x-x_{0})^T \nabla f(x_{0}) +1/2(x-x_{0})^T \nabla^{2} f(x_{0})(x-x_{0}) + R$ 
$f(x)=\frac{1}{2\pi\sqrt{|\Sigma|}} + 0 +( \frac{-1}{2})(\frac{1}{4\pi\sqrt{|\Sigma|^{3}}}) [2\sigma_{22}(x_{1}-u_{1})^2- 4\sigma_{21}(x_{1}-u_{1})(x_{2}-u_{2})+2\sigma_{11}(x_{2}-u_{2})^2 ]$
$\boxed{f(x)= (2\pi\sqrt{|\Sigma|})^{-1} +(4\pi\sqrt {|\Sigma|^{3} })^{-1}    [-\sigma_{22}(x_{1}-u_{1})^2+ 2\sigma_{21}(x_{1}-u_{1})(x_{2}-u_{2})-\sigma_{11}(x_{2}-u_{2})^2 + R]}$
