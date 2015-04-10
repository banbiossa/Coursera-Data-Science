---
title: "week2"
output: html_document
---

Markdown
### heading
# Heading
## Secondary Heading
### even smaller heading

### Unordered lists
- first
- second

### Ordered lists
1. First
3. Third
2. Second

Doesn't matter which order you lay them out

### Syntax
#### Links
[RStudio](http://www.rstudio.com/)

#### Advance Links  
I spend so much time reading [Simply Statistics][1]!  

  [1]: http://simplystatistics.org/ "Simply Statistics"

Here's an inline link to [Google](http://www.google.com/).
Here's a reference-style link to [Google][1].
Here's a very readable link to [Yahoo!][yahoo].

  [1]: http://www.google.com/
  [yahoo]: http://www.yahoo.com/

Here's a <span class="hi">[poorly-named link](http://www.google.com/ "Google")</span>.
Never write "[click here][^2]".
Visit [us][web].

  [^2]: http://www.w3.org/QA/Tips/noClickHere (Advice against the phrase "click here")    
   
  [web]: http://stackoverflow.com/ "Stack Overflow"
  
#### New lines
two spaces  create a new line

### What is markdown?  
- you can concentrate on the content  
- r markdown is markdown for r, we'll use knitr




```r
library(datasets)
summary(airquality)
```

```
##      Ozone           Solar.R           Wind             Temp      
##  Min.   :  1.00   Min.   :  7.0   Min.   : 1.700   Min.   :56.00  
##  1st Qu.: 18.00   1st Qu.:115.8   1st Qu.: 7.400   1st Qu.:72.00  
##  Median : 31.50   Median :205.0   Median : 9.700   Median :79.00  
##  Mean   : 42.13   Mean   :185.9   Mean   : 9.958   Mean   :77.88  
##  3rd Qu.: 63.25   3rd Qu.:258.8   3rd Qu.:11.500   3rd Qu.:85.00  
##  Max.   :168.00   Max.   :334.0   Max.   :20.700   Max.   :97.00  
##  NA's   :37       NA's   :7                                       
##      Month            Day      
##  Min.   :5.000   Min.   : 1.0  
##  1st Qu.:6.000   1st Qu.: 8.0  
##  Median :7.000   Median :16.0  
##  Mean   :6.993   Mean   :15.8  
##  3rd Qu.:8.000   3rd Qu.:23.0  
##  Max.   :9.000   Max.   :31.0  
## 
```

Let's make a plot of the data


```r
plot(airquality)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png) 

Here's a regression model of ozone, wind, solar radiation, and temperature


```r
library(stats)
fit <- lm(Ozone ~ Wind + Solar.R + Temp, data = airquality)
summary(fit)
```

```
## 
## Call:
## lm(formula = Ozone ~ Wind + Solar.R + Temp, data = airquality)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -40.485 -14.219  -3.551  10.097  95.619 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -64.34208   23.05472  -2.791  0.00623 ** 
## Wind         -3.33359    0.65441  -5.094 1.52e-06 ***
## Solar.R       0.05982    0.02319   2.580  0.01124 *  
## Temp          1.65209    0.25353   6.516 2.42e-09 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 21.18 on 107 degrees of freedom
##   (42 observations deleted due to missingness)
## Multiple R-squared:  0.6059,	Adjusted R-squared:  0.5948 
## F-statistic: 54.83 on 3 and 107 DF,  p-value: < 2.2e-16
```

### Literate programming

knitr is good for most things, but not for long/specific documents

#### complicated way of knitting

```r
library(knitr)
setwd("/Users//shota/git//Coursera-Data-Science/Reproducible research/")
knit2html("week2.Rmd")
```

```
## 
## 
## processing file: week2.Rmd
```

```
## 
##   ordinary text without R code
## 
## 
## label: unnamed-chunk-5
## 
##   ordinary text without R code
## 
## 
## label: unnamed-chunk-6 (with options) 
## List of 1
##  $ echo: logi TRUE
```

```
## 
##   ordinary text without R code
## 
## 
## label: unnamed-chunk-7
## 
##   ordinary text without R code
## 
## 
## label: unnamed-chunk-8
```

```
## output file: week2.md
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 

```r
browseURL("week2.html")
```