warmup2
================
Yowsean Li
9/11/2017

``` r
load("nba2017-salary-points.RData")
ls()
```

    ## [1] "player"   "points"   "points1"  "points2"  "points3"  "position"
    ## [7] "salary"   "team"

### Quantitative Variable - Points

``` r
summary(points)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##     0.0   156.0   432.0   546.6   780.0  2558.0

``` r
sd(points)
```

    ## [1] 489.0156

-   Mean: 546.6
-   Standard Deviation: 489.0
-   Minimum: 0.0
-   Maximum: 2558.0
-   Median: 432.0
-   1st Quartile: 156.0
-   3rd Quartile: 780.0

``` r
hist(points)
```

![](up02-yowsean-li_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

``` r
boxplot(points)
```

![](up02-yowsean-li_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

The distribution of points is skewed to the right with a spread from 0 to 2000 points.

### Qualitative Variable - position

``` r
factor(position)
```

    ##   [1] C  PF SG PG SF PG SF SG SF PF PF C  SG PG C  C  SF PG PF C  SG SG SF
    ##  [24] PG PF SG PG SF SF C  SF SG PG SG SF PG C  C  PG C  SG SF PF PF PF SF
    ##  [47] SG PG PF C  C  C  PG C  PF SF SG SG PG SF PG C  PF PG SF PF PG SF C 
    ##  [70] PF PF SF SG SF C  PF SG C  SF SG PG PF PF SG PF C  SG PG C  SF PF PG
    ##  [93] PG PF SG PF SG C  SF PF PF SG PF PG C  SG SG SG PG SF C  PG PF SF PG
    ## [116] C  SG PG C  PF PF SG SF SF PF SG PG C  SG C  C  C  PG C  SG PF PG PF
    ## [139] SG SF SG SF PG SF PF PG PG PF PF C  SG PF PG SG PF SF C  SG PG SG SF
    ## [162] PG SG PG C  SG PF C  PF C  PF SF SG SG C  SF C  PG PG SF PG SG PF SG
    ## [185] SG SF C  SG C  SF PF PF SG C  PG C  SF SG C  SF PG C  PG C  SF PF SG
    ## [208] C  SF PG PG SG C  SF PF SG SF SG PG PF SF C  C  PF SG PF C  SF C  SG
    ## [231] SF SG PG PG C  SG SG PF PF PG C  C  SG SF SG PF SG PG C  PG PG C  C 
    ## [254] SG PG PG PF SG C  SG PF SF SF SF SF SG PF PF PF PG C  C  SG SG SF C 
    ## [277] SF PG SF SG PF PG PF PG SF C  SF SF PF PG SG C  PG PF SG SF PF SF C 
    ## [300] SF PF SF PF PG PG PG C  PF SG PG PF SF C  SF PF PF C  PG SG SG SF PG
    ## [323] SG PF SF SG SG PG PF SF SF C  SF PF PF SG PG SG SF PF PG SG SG PG PF
    ## [346] PF SG C  SF C  C  SG SF C  C  SF PF SF C  PF SG SG PG C  PG SF PG C 
    ## [369] SG PG PF PF C  PF PG PF C  SF C  PG SG PG PF SG SG SG PG SG C  C  PG
    ## [392] SG SF PF PG SF C  PF SF SG C  PF C  C  PG PF SF PG SF PG SG SF SF PG
    ## [415] SG C  SG PF PF SF SF SG C  PF C  PG C  C  SG SF SG PF SG PG PF SG PF
    ## [438] PG SF PG C 
    ## Levels: C PF PG SF SG

``` r
table(position)
```

    ## position
    ##  C PF PG SF SG 
    ## 89 89 85 83 95

``` r
table(position)/length(position)
```

    ## position
    ##         C        PF        PG        SF        SG 
    ## 0.2018141 0.2018141 0.1927438 0.1882086 0.2154195

We can see that the distribution between positions is very uniform. Each position accounts for around 20% of players.

``` r
barplot(table(position)/length(position))
```

![](up02-yowsean-li_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-8-1.png)

### Report

-   Hard parts were researching R docs to find the right functions to use.
-   Easier parts were plotting graphs.
-   I didn't encounter any significant errors.
-   I still need to learn how to manipulate graphs and data
-   The most time consuming part was researching the R docs
-   I did not collaborate
-   There were no frustrating issues
