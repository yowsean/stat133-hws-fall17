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
```

![](hw01-yowsean-li_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)

3. Correlation between Points and Salary
========================================
