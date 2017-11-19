# ===================================================================
# Title: Functions
# Description: Various functions for grades visualizer
# Author: Yowsean Li
# Date: 11-13-2017
# ===================================================================

# Title: remove_missing()
# Description: Remove missing values from vector
# Input: vector
# Output: cleaned vector with no missing values
remove_missing <- function(v) {
  r <- c()
  for (i in v) {
    if (!is.na(i)) {
      r <- c(r, i)
    }
  }
  r
}

# Title: get_minimum()
# Description: get minimum value of numerical vector
# Input: vector
# Output: numerical value
get_minimum <- function(v, na.rm=TRUE) {
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  v <- sort(v)
  v[1]
}

# Title: get_maximum()
# Description: get maximum value of numerical vector
# Input: vector
# Output: numerical value
get_maximum <- function(v, na.rm=TRUE) {
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  v <- sort(v, decreasing=TRUE)
  v[1]
}

# Title: get_range()
# Description: computes max(v)-min(v) for input vector v
# Input: vector
# Output: numerical value
get_range <- function(v, na.rm=TRUE) {
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  get_maximum(v) - get_minimum(v)
}

# Title: get_percentile10()
# Description: computes 10th percentile of vector
# Input: vector
# Output: numerical value
get_percentile10 <- function(v, na.rm=TRUE) {
  unname(quantile(v, c(.1), na.rm=na.rm))
}

# Title: get_percentile90()
# Description: computes 90th percentile of vector
# Input: vector
# Output: numerical value
get_percentile90 <- function(v, na.rm=TRUE) {
  unname(quantile(v, c(.9), na.rm=na.rm))
}

# Title: get_median()
# Description: returns median of vector
# Input: vector
# Output: numerical value
get_median <- function(v, na.rm=TRUE) {
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  if (length(v) %% 2 == 0) {
    (v[length(v)/2] + v[(length(v)/2) + 1])/2
  } else {
    v[(length(v)%/%2 + 1)]
  }
}

# Title: get_average()
# Description: returns average of vector
# Input: vector
# Output: numerical value
get_average <- function(v, na.rm=TRUE) {
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  sum <- 0
  for (x in v) {
    sum <- sum + x
  }
  sum / length(v)
}

# Title: get_stdev()
# Description: returns standard deviation of vector
# Input: vector
# Output: numerical value
get_stdev <- function(v, na.rm=TRUE) {
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  x_bar <- get_average(v)
  sum <- 0
  for (x in v) {
    sum <- sum + (x - x_bar)^2
  }
  sqrt(sum / (length(v) - 1))
}

# Title: get_quartile1()
# Description: returns first quartile of vector
# Input: vector
# Output: numerical value
get_quartile1 <- function(v, na.rm=TRUE) {
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  unname(quantile(v, 0.25))
}

# Title: get_quartile3()
# Description: returns third quartile of vector
# Input: vector
# Output: numerical value
get_quartile3 <- function(v, na.rm=TRUE) {
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  unname(quantile(v, 0.75))
}

# Title: count_missing()
# Description: returns number of missing values
# Input: vector
# Output: numerical value
count_missing <- function(v) {
  count <- 0
  for (i in v) {
    if (is.na(i)) {
      count <- count + 1
    }
  }
  count
}

# Title: summary_stats()
# Description: returns list of summary stats of vector
# Input: vector
# Output: list of summary stats 
summary_stats <- function(v) {
  list(minimum=get_minimum(v),
       percent10=get_percentile10(v),
       quartile1=get_quartile1(v),
       median=get_median(v),
       mean=get_average(v),
       quartile3=get_quartile3(v),
       percent90=get_percentile90(v),
       maximum=get_maximum(v),
       range=get_range(v),
       stdev=get_stdev(v),
       missing=count_missing(v))
}

# Title: print_stats()
# Description: takes list of summary stats and prints in formatted form
# Input: list of summary stats
# Output: prints summary stats
print_stats <- function(l) {
  names <- sprintf("%-9s", names(l))
  for (i in 1:length(l)) {
    print(paste(names[i], format(round(as.numeric(l[i]), 4), nsmall=4), sep=": "))
  }
}

# Title: rescale100()
# Description: scales vector to a given min and max
# Input: vector x, minimum value xmin, maximum value xmax
# Output: rescaled vector
rescale100 <- function(x, xmin, xmax) {
  100 * ((x - xmin)/(xmax-xmin))
}

# Title: drop_lowest()
# Description: drops lowest value of vector
# Input: vector size n
# Output: vector size n-1
drop_lowest <- function(v) {
  min <- get_minimum(v)
  n <- c()
  dropped <- FALSE
  for (i in v) {
    if (i != min & dropped == FALSE) {
      n <- c(n, i)
    } else if (dropped == TRUE) {
      n <- c(n, i)
    } else {
      dropped <- TRUE
    }
  }
  n
}

# Title: score_homework()
# Description: computes single homework value
# Input: vector of homework scores
# Output: average of homework scores
score_homework <- function(v, drop) {
  if (drop == TRUE) {
    v <- drop_lowest(v)
  }
  get_average(v)
}

# Title: score_quiz()
# Description: computes single quiz value
# Input: vector of quiz scores
# Output: average of quiz scores
score_quiz <- function(v, drop) {
  if (drop == TRUE) {
    v <- drop_lowest(v)
  }
  get_average(v)
}

# Title: score_lab()
# Description: computes lab score
# Input: lab attendance input
# Output: lab score
score_lab <- function(i) {
  if (i >= 11) {
    100
  } else if (i > 9) {
    80
  } else if (i > 8) {
    60
  } else if (i > 7) {
    40
  } else if (i > 6) {
    20
  } else {
    0
  }
}