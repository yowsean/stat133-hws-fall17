hw01-yowsean-li
================
Yowsean Li
9/14/2017

``` r
# load data file
load("data/nba2017-salary-points.RData")
ls()
```

    ## [1] "experience" "player"     "points"     "points1"    "points2"   
    ## [6] "points3"    "position"   "salary"     "team"

1. Data Preprocessing
=====================

``` r
salary_millions = salary / 1000000
```

``` r
experience <- as.numeric(replace(experience, experience=="R", 0))
```

``` r
position_fac <- factor(position)
levels(position_fac) <- c('center', 'power_fwd', 'point_guard', 'small_fwd', 'shoot_guard')
```

``` r
table(position_fac)
```

    ## position_fac
    ##      center   power_fwd point_guard   small_fwd shoot_guard 
    ##          89          89          85          83          95

2. Scatterplot of Points and Salary
===================================

``` r
plot(points, salary_millions, xlab='Points', ylab='Salary (in millions)')
title('Scatter Plot of Points and Salary')
```

![](hw01-yowsean-li_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)

3. Correlation between Points and Salary
========================================

``` r
n <- length(player)
mean_points <- sum(points) / n
mean_salary <- sum(salary_millions) / n
var_points <- sum((points - mean_points)^2) / (n-1)
var_salary <- sum((salary_millions - mean_salary)^2) / (n-1)
sd_points <- sqrt(var_points)
sd_salary <- sqrt(var_salary)
cov_pts_salary <- sum((points - mean_points)*(salary_millions - mean_salary)) / (n-1)
cor_pts_salary <- cov_pts_salary / (sd_points * sd_salary)

paste('n:', n)
```

    ## [1] "n: 441"

``` r
paste('mean_points:', mean_points)
```

    ## [1] "mean_points: 546.605442176871"

``` r
paste('mean_salary:', mean_salary)
```

    ## [1] "mean_salary: 6.18701394557823"

``` r
paste('var_points:', var_points)
```

    ## [1] "var_points: 239136.243970315"

``` r
paste('var_salary:', var_salary)
```

    ## [1] "var_salary: 43.1897349519223"

``` r
paste('sd_points:', sd_points)
```

    ## [1] "sd_points: 489.015586633305"

``` r
paste('sd_salary:', sd_salary)
```

    ## [1] "sd_salary: 6.57188975500368"

``` r
paste('cov_pts_salary:', cov_pts_salary)
```

    ## [1] "cov_pts_salary: 2046.21251191257"

``` r
paste('mean_salary:', mean_salary)
```

    ## [1] "mean_salary: 6.18701394557823"

``` r
paste('cor_pts_salary:', cor_pts_salary)
```

    ## [1] "cor_pts_salary: 0.636704273251037"

4. Simple Linear Regression
===========================

``` r
b_1 <- cor_pts_salary * (sd_salary / sd_points)
b_0 <- mean_salary - b_1 * mean_points
X <- points
Y <- b_0 + b_1 * X

summary(Y)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   1.510   2.845   5.206   6.187   8.184  23.398

Summary:

-   Minimum: 1.510
-   1st Quartile: 2.845
-   Median: 5.206
-   Mean: 6.187
-   3rd Quartile: 8.184
-   Maximum: 23.298

The regression equation is:

``` r
Y_hat <- 1.510 + 0.009 * X
```

The slope coefficient b\_1 is the average increase in salary per point starting from the intercept.

The intercept term b\_0 is the minimum salary.

Predicted Salaries:

-   0 points: 1.510 million
-   100 points: 2.366 million
-   500 points: 5.789 million
-   1000 points: 10.067 million
-   2000 points: 18.623 million

5. Plotting the Regression Line
===============================

``` r
plot(points, salary_millions, xlab='Points', ylab='Salary (in millions)')
abline(b_0, b_1)
lines(lowess(points, salary_millions))
text(2300, 17, labels = 'regression')
text(2000, 25, labels = 'lowess')
title('Regression and Lowess Lines')
```

![](hw01-yowsean-li_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-10-1.png)

6. Regression Residuals and Coefficient of Determination *R*<sup>2</sup>
========================================================================

``` r
residuals <- salary_millions - Y
summary(residuals)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ## -14.190  -2.794  -1.095   0.000   2.555  18.810

``` r
RSS <- sum(residuals^2)
TSS <- sum((salary_millions - mean_salary)^2)
R2 <- 1 - RSS/TSS
paste('RSS: ', RSS)
```

    ## [1] "RSS:  11299.6169438272"

``` r
paste('TSS: ', TSS)
```

    ## [1] "TSS:  19003.4833788458"

``` r
paste('R2: ', R2)
```

    ## [1] "R2:  0.405392331576131"

7. Exploring Position and Experience
====================================

``` r
plot(experience, salary_millions, xlab='Years of Experience', ylab='Salary (in millions)')
title('Scatter Plot with lowess smooth')
lines(lowess(experience, salary_millions))
```

![](hw01-yowsean-li_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-13-1.png) We can see that salary does increase with more experience, but reaches a peak and slowly starts to decrease at 5 years.

``` r
library(scatterplot3d)
scatterplot3d(points, experience, salary_millions)
title('3D Scatterplot')
```

![](hw01-yowsean-li_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-14-1.png) This plot shows us that salary does increase as experience and points increase.

``` r
boxplot(salary_millions~position, xlab="Position", ylab="Salary (millions)")
title('Boxplot of Position and Salary')
```

![](hw01-yowsean-li_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-15-1.png) The boxplot shows that salary does not seem to have a strong correlation with position, although centers seem to be paid the most overall.

8. Comments and Reflections
===========================

-   The hardest parts were figuring out the correct parameters for different functions.
-   The easier parts were converting the equations into code.
-   This was not my first time using Git or Github.
-   I did not need help completing the assignment.
-   It took me a couple hours to finish.
-   There was no particular part that was most time consuming.
-   The most exciting part was drawing the graphs since I could actually visualize the data in different ways.