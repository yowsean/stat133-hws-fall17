Use of Color in Data Visualization
==================================

### Introduction

Color is used widely in data visualization, as it provides better
aesthetics, but it also allows for much more flexibility which can
create plots that are easier to understand and visualize. In this post,
I will also explore a few examples of when to incorporate color into
plots and show how color adds another dimension for plots.

### Discussion and Examples

#### Setup

    # Import packages
    library(dplyr)

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    library(ggplot2)
    # Import Data
    dat <- read.csv('../data/nba2017-player-statistics.csv', colClasses=c("character", "character", "factor", "character", "double", rep("integer", 19)))
    dat2 <- read.csv('../data/nba2017-roster.csv', colClasses=c("character", "character", "factor", rep("integer", 4), "double"))
    # Data Cleaning - replace experience 'R' with '0'
    dat$Experience[dat$Experience=="R"] <- "0"
    dat$Experience <- as.integer(dat$Experience)
    # Add RPM Column
    dat <- mutate(dat, RPM=(OREB+DREB)/MIN)

categories, grouping color by position mixing quantitative and
categorical data

    ggplot(data=dat, aes(x=Salary, y=MIN)) +
      geom_point() +
      ggtitle("Salary to Minutes Played")

![](post01-yowsean-li_files/figure-markdown_strict/unnamed-chunk-2-1.png)

    ggplot(data=dat, aes(x=Salary, y=Rank)) +
      geom_point() +
      ggtitle("Salary to Rank")

![](post01-yowsean-li_files/figure-markdown_strict/unnamed-chunk-3-1.png)

    ggplot(data=dat, aes(x=Salary, y=MIN, color=Rank)) +
      geom_point() +
      ggtitle("Salary to Minutes Played")

![](post01-yowsean-li_files/figure-markdown_strict/unnamed-chunk-4-1.png)

overlay two barplots, transparency, comparison

    ggplot(data=dat, aes(x=RPM)) +
      geom_density() +
      ggtitle("Rebounds per Minute by Height") +
      facet_wrap(~ Position)

![](post01-yowsean-li_files/figure-markdown_strict/unnamed-chunk-5-1.png)

    ggplot(data=dat, aes(x=RPM, color=Position)) +
      geom_density() + 
      ggtitle("Rebounds per Minute by Height")

![](post01-yowsean-li_files/figure-markdown_strict/unnamed-chunk-6-1.png)

contour overplotting - age/gp

    ggplot(data=dat, aes(x=Age, y=Rank)) +
      geom_point() +
      ggtitle("Age and Rank")

![](post01-yowsean-li_files/figure-markdown_strict/unnamed-chunk-7-1.png)

    ggplot(data=dat, aes(x=Age, y=Rank)) +
      geom_point(alpha=0.25) + 
      ggtitle("Age and Rank") +
      stat_density_2d(aes(alpha=..level.., fill=..level..), geom="polygon")

![](post01-yowsean-li_files/figure-markdown_strict/unnamed-chunk-8-1.png)

color schemes, themes, choosing colors, ggthemes It is also important to
take the context of the data when choosing colors.

    ggplot(data=dat2, aes(x=weight, y=height, color=position)) +
      geom_point() +
      ggtitle("weight to height") +
      scale_color_brewer(palette="Purples")

![](post01-yowsean-li_files/figure-markdown_strict/unnamed-chunk-9-1.png)

    ggplot(data=dat2, aes(x=weight, y=height, color=position)) +
      geom_point() +
      ggtitle("weight to height") +
      scale_color_brewer(palette="Set1")

![](post01-yowsean-li_files/figure-markdown_strict/unnamed-chunk-10-1.png)

### Conclusion

### References

<https://stats.stackexchange.com/questions/31726/scatterplot-with-contour-heat-overlay>

<https://www.r-statistics.com/2016/07/using-2d-contour-plots-within-ggplot2-to-visualize-relationships-between-three-variables/>

<http://ggplot2.tidyverse.org/reference/geom_point.html>

<https://infogram.com/blog/color-theory-dos-and-donts-for-data-visualization/>

<http://www.sthda.com/english/wiki/ggplot2-colors-how-to-change-colors-automatically-and-manually#gradient-colors-for-scatter-plots>

<https://cran.r-project.org/web/packages/RColorBrewer/RColorBrewer.pdf>
