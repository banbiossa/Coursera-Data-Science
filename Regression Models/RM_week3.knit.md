---
title: "Regression Models week3"
output:
  pdf_document:
    latex_engine: lualatex
---

# Swiss fertility data

```r
library(datasets)
data(swiss)
require(stats)
require(graphics)
pairs(swiss, panel = panel.smooth, main = "Swiss data", col = 3 + (swiss$Catholic>50))
```

![](RM_week3_files/figure-latex/swiss-1.pdf) 

```r
?swiss
summary(lm(Fertility ~ . , data = swiss)) #. is all the variables
```

```
## 
## Call:
## lm(formula = Fertility ~ ., data = swiss)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -15.2743  -5.2617   0.5032   4.1198  15.3213 
## 
## Coefficients:
##                  Estimate Std. Error t value Pr(>|t|)    
## (Intercept)      66.91518   10.70604   6.250 1.91e-07 ***
## Agriculture      -0.17211    0.07030  -2.448  0.01873 *  
## Examination      -0.25801    0.25388  -1.016  0.31546    
## Education        -0.87094    0.18303  -4.758 2.43e-05 ***
## Catholic          0.10412    0.03526   2.953  0.00519 ** 
## Infant.Mortality  1.07705    0.38172   2.822  0.00734 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 7.165 on 41 degrees of freedom
## Multiple R-squared:  0.7067,	Adjusted R-squared:  0.671 
## F-statistic: 19.76 on 5 and 41 DF,  p-value: 5.594e-10
```

- agriculture is -0.1721

```r
summary(lm(Fertility ~ Agriculture, data = swiss))$coefficients
```

```
##               Estimate Std. Error   t value     Pr(>|t|)
## (Intercept) 60.3043752 4.25125562 14.185074 3.216304e-18
## Agriculture  0.1942017 0.07671176  2.531577 1.491720e-02
```

Adjustment reversed the effect.

Let's simulate this

```r
n <- 100
x2 <- 1:n 
x1 <- .1 * x2 + runif(n -.1, .1); 
```

```
## Warning in 0.1 * x2 + runif(n - 0.1, 0.1): 長いオブジェクトの長さが短いオブジェクトの長さの倍数になっていま
## せん
```

```r
y = - x1 + x2 + rnorm(n, sd = .01)
summary(lm(y ~ x1))$coef
```

```
##              Estimate Std. Error    t value      Pr(>|t|)
## (Intercept) -4.813999  0.5231732  -9.201539  6.544513e-15
## x1           8.795142  0.0821928 107.006235 2.592161e-103
```

```r
summary(lm(y ~ x1 + x2))$coef
```

```
##                  Estimate   Std. Error      t value      Pr(>|t|)
## (Intercept)  0.0005941553 0.0028164379    0.2109598  8.333612e-01
## x1          -0.9983148640 0.0039140806 -255.0573084 6.179222e-139
## x2           0.9998194229 0.0003982186 2510.7298334 3.054533e-235
```

- This can happen.
- which is the correct model?

# Include unnecessary stuff

```r
z <- swiss$Agriculture + swiss$Education
lm(Fertility ~ . + z, data = swiss)
```

```
## 
## Call:
## lm(formula = Fertility ~ . + z, data = swiss)
## 
## Coefficients:
##      (Intercept)       Agriculture       Examination         Education  
##          66.9152           -0.1721           -0.2580           -0.8709  
##         Catholic  Infant.Mortality                 z  
##           0.1041            1.0770                NA
```

- z can't add any information
- z becomes NA

# Dummy variables

- it depends how you choose your binary variable
* $Y_i = \beta_0 + X_{i1} \beta_1 + X_{i2} \beta_2 + \epsilon_i$.

# Insect sprays

```
## Loading required package: ggplot2
```

![](RM_week3_files/figure-latex/unnamed-chunk-1-1.pdf) 


```r
summary(lm(count~spray, data = InsectSprays))$coef
```

```
##                Estimate Std. Error    t value     Pr(>|t|)
## (Intercept)  14.5000000   1.132156 12.8074279 1.470512e-19
## sprayB        0.8333333   1.601110  0.5204724 6.044761e-01
## sprayC      -12.4166667   1.601110 -7.7550382 7.266893e-11
## sprayD       -9.5833333   1.601110 -5.9854322 9.816910e-08
## sprayE      -11.0000000   1.601110 -6.8702352 2.753922e-09
## sprayF        2.1666667   1.601110  1.3532281 1.805998e-01
```

```r
summary(lm(count ~ 
             I(1 * (spray == 'B')) + I(1 * (spray == 'C')) + 
             I(1 * (spray == 'D')) + I(1 * (spray == 'E')) +
             I(1 * (spray == 'F'))
           , data = InsectSprays))$coef
```

```
##                          Estimate Std. Error    t value     Pr(>|t|)
## (Intercept)            14.5000000   1.132156 12.8074279 1.470512e-19
## I(1 * (spray == "B"))   0.8333333   1.601110  0.5204724 6.044761e-01
## I(1 * (spray == "C")) -12.4166667   1.601110 -7.7550382 7.266893e-11
## I(1 * (spray == "D"))  -9.5833333   1.601110 -5.9854322 9.816910e-08
## I(1 * (spray == "E")) -11.0000000   1.601110 -6.8702352 2.753922e-09
## I(1 * (spray == "F"))   2.1666667   1.601110  1.3532281 1.805998e-01
```

# what if you include all six

```r
summary(lm(count ~ 
   I(1 * (spray == 'B')) + I(1 * (spray == 'C')) +  
   I(1 * (spray == 'D')) + I(1 * (spray == 'E')) +
   I(1 * (spray == 'F')) + I(1 * (spray == 'A')), data = InsectSprays))$coef
```

```
##                          Estimate Std. Error    t value     Pr(>|t|)
## (Intercept)            14.5000000   1.132156 12.8074279 1.470512e-19
## I(1 * (spray == "B"))   0.8333333   1.601110  0.5204724 6.044761e-01
## I(1 * (spray == "C")) -12.4166667   1.601110 -7.7550382 7.266893e-11
## I(1 * (spray == "D"))  -9.5833333   1.601110 -5.9854322 9.816910e-08
## I(1 * (spray == "E")) -11.0000000   1.601110 -6.8702352 2.753922e-09
## I(1 * (spray == "F"))   2.1666667   1.601110  1.3532281 1.805998e-01
```

## What if we omit the intercept?

```r
summary(lm(count ~ spray - 1, data = InsectSprays))$coef
```

```
##         Estimate Std. Error   t value     Pr(>|t|)
## sprayA 14.500000   1.132156 12.807428 1.470512e-19
## sprayB 15.333333   1.132156 13.543487 1.001994e-20
## sprayC  2.083333   1.132156  1.840148 7.024334e-02
## sprayD  4.916667   1.132156  4.342749 4.953047e-05
## sprayE  3.500000   1.132156  3.091448 2.916794e-03
## sprayF 16.666667   1.132156 14.721181 1.573471e-22
```

```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
summarise(group_by(InsectSprays, spray), mn = mean(count))
```

```
## Source: local data frame [6 x 2]
## 
##   spray        mn
## 1     A 14.500000
## 2     B 15.333333
## 3     C  2.083333
## 4     D  4.916667
## 5     E  3.500000
## 6     F 16.666667
```

## Reordering the levels

```r
spray2 <- relevel(InsectSprays$spray, "C")
summary(lm(count ~ spray2, data = InsectSprays))$coef
```

```
##              Estimate Std. Error  t value     Pr(>|t|)
## (Intercept)  2.083333   1.132156 1.840148 7.024334e-02
## spray2A     12.416667   1.601110 7.755038 7.266893e-11
## spray2B     13.250000   1.601110 8.275511 8.509776e-12
## spray2D      2.833333   1.601110 1.769606 8.141205e-02
## spray2E      1.416667   1.601110 0.884803 3.794750e-01
## spray2F     14.583333   1.601110 9.108266 2.794343e-13
```
---

- You can also do it manualy if you try hard enough

# Hunger

```r
hunger <- read.csv("/Users/shotashimizu/git/courses/07_RegressionModels/02_02_multivariateExamples/hunger.csv")
hunger <- hunger[hunger$Sex != "Both sexes",]
head(hunger)
```

```
##                                Indicator Data.Source PUBLISH.STATES Year
## 1 Children aged <5 years underweight (%) NLIS_310044      Published 1986
## 2 Children aged <5 years underweight (%) NLIS_310233      Published 1990
## 3 Children aged <5 years underweight (%) NLIS_312902      Published 2005
## 5 Children aged <5 years underweight (%) NLIS_312522      Published 2002
## 6 Children aged <5 years underweight (%) NLIS_312955      Published 2008
## 8 Children aged <5 years underweight (%) NLIS_312963      Published 2008
##              WHO.region       Country    Sex Display.Value Numeric Low
## 1                Africa       Senegal   Male          19.3    19.3  NA
## 2              Americas      Paraguay   Male           2.2     2.2  NA
## 3              Americas     Nicaragua   Male           5.3     5.3  NA
## 5 Eastern Mediterranean        Jordan Female           3.2     3.2  NA
## 6                Africa Guinea-Bissau Female          17.0    17.0  NA
## 8                Africa         Ghana   Male          15.7    15.7  NA
##   High Comments
## 1   NA       NA
## 2   NA       NA
## 3   NA       NA
## 5   NA       NA
## 6   NA       NA
## 8   NA       NA
```

```r
lm <- lm(hunger$Numeric ~ hunger$Year)
plot(hunger$Year, hunger$Numeric, pch =19, col = "blue")
```

![](RM_week3_files/figure-latex/hunger-1.pdf) 

# Remember the linear model
$$H v_i = b_0 + b_1 Y_i + e_i$$

