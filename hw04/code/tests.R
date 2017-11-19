# ===================================================================
# Title: Test
# Description: Unit tests for Functions
# Author: Yowsean Li
# Date: 11-13-2017
# ===================================================================

# Test remove_missing()
context("remove_missing")
test_that("remove_missing works", {
  expect_equal(remove_missing(c(1, 2, 3, NA, 4)), c(1, 2, 3, 4))
  expect_equal(remove_missing(c(1, 2, 3, 4)), c(1, 2, 3, 4))
  expect_equal(remove_missing(c(NA, NA, NA, NA)), c())
  expect_equal(remove_missing(c(3, 4, 5, NA)), c(3, 4, 5))
})

# Test get_minimum()
context("get_minimum")
test_that("get_minimum works", {
  expect_equal(get_minimum(c(5, 2, 1, NA, 4)), 1)
  expect_equal(get_minimum(c(9, 2, 14, 4)), 2)
  expect_equal(get_minimum(c(NA, NA, 6, NA)), 6)
  expect_equal(get_minimum(c(3, 7, 5, NA), na.rm=FALSE), 3)
})

# Test get_maximum()
context("get_maximum")
test_that("get_maximum works", {
  expect_equal(get_maximum(c(3, 2, 3, NA, 4)), 4)
  expect_equal(get_maximum(c(5, 11, 3, 4)), 11)
  expect_equal(get_maximum(c(NA, NA, 6, NA)), 6)
  expect_equal(get_maximum(c(13, 4, 5, NA), na.rm=FALSE), 13)
})

# Test get_range()
context("get_range")
test_that("get_range works", {
  expect_equal(get_range(c(1, 2, 3, NA, 4)), 3)
  expect_equal(get_range(c(5, 2, 3, 4)), 3)
  expect_equal(get_range(c(NA, 0, 6, NA)), 6)
  expect_equal(get_range(c(3, 4, 5, NA), na.rm=FALSE), 2)
})

# Test get_percentile10()
context("get_percentile10")
test_that("get_percentile10 works", {
  expect_equal(get_percentile10(c(1, 2, 3, NA, 4)), 1.3)
  expect_equal(get_percentile10(c(5, 2, 13, 2, 4)), 2)
  expect_equal(get_percentile10(c(NA, 10, NA)), 10)
  expect_equal(get_percentile10(c(8, 2, 5, NA)), 2.6)
})

# Test get_percentile90()
context("get_percentile90")
test_that("get_percentile90 works", {
  expect_equal(get_percentile90(c(1, 2, 3, NA, 4)), 3.7)
  expect_equal(get_percentile90(c(5, 2, 13, 2, 4)), 9.8)
  expect_equal(get_percentile90(c(NA, 10, NA)), 10)
  expect_equal(get_percentile90(c(8, 2, 5, NA)), 7.4)
})

# Test get_median()
context("get_median")
test_that("get_median works", {
  expect_equal(get_median(c(1, 2, 3, 4)), median(c(1, 2, 3, 4)))
  expect_equal(get_median(c(5, 2, 13, 2, 4)), median(c(5, 2, 13, 2, 4)))
  expect_equal(get_median(c(NA, 10, NA)), median(c(10)))
  expect_equal(get_median(c(8, 2, 5, NA)), median(c(8, 2, 5)))
})

# Test get_average()
context("get_average")
test_that("get_average works", {
  expect_equal(get_average(c(1, 2, 3, NA, 4)), 10/4)
  expect_equal(get_average(c(5, 2, 13, 2, 4)), 26/5)
  expect_equal(get_average(c(NA, 10, NA)), 10)
  expect_equal(get_average(c(8, 2, 5, NA)), 15/3)
})

# Test get_stdev()
context("get_stdev")
test_that("get_stdev works", {
  expect_equal(get_stdev(c(1, 2, 3, NA, 4)), sd(c(1, 2, 3, 4)))
  expect_equal(get_stdev(c(5, 2, 13, 2, 4)), sd(c(5, 2, 13, 2, 4)))
  expect_equal(get_stdev(c(NA, 10, NA)), sd(c(10)))
  expect_equal(get_stdev(c(8, 2, 5, NA)), sd(c(8, 2, 5)))
})

# Test get_quartile1()
context("get_quartile1")
test_that("get_quartile1 works", {
  expect_equal(get_quartile1(c(1, 2, 3, NA, 4)), 1.75)
  expect_equal(get_quartile1(c(5, 2, 13, 2, 4)), 2)
  expect_equal(get_quartile1(c(NA, 10, NA)), 10)
  expect_equal(get_quartile1(c(8, 2, 5, NA)), 3.5)
})

# Test get_quartile3()
context("get_quartile3")
test_that("get_quartile3 works", {
  expect_equal(get_quartile3(c(1, 2, 3, NA, 4)), 3.25)
  expect_equal(get_quartile3(c(5, 2, 13, 2, 4)), 5)
  expect_equal(get_quartile3(c(NA, 10, NA)), 10)
  expect_equal(get_quartile3(c(8, 2, 5, NA)), 6.5)
})

# Test count_missing()
context("count_missing")
test_that("count_missing works", {
  expect_equal(count_missing(c(1, 2, 3, NA, 4)), 1)
  expect_equal(count_missing(c(5, 2, 13, 2, 4)), 0)
  expect_equal(count_missing(c(NA, 10, NA)), 2)
  expect_equal(count_missing(c(8, 2, NA, NA, NA)), 3)
})

# Test summary_stats()
context("summary_stats")
test_that("summary_stats works", {
  expect_equal(summary_stats(c(1, 2, 3, NA, 4))$mean, mean(c(1, 2, 3, 4)))
  expect_equal(summary_stats(c(5, 2, 13, 2, 4))$minimum, 2)
  expect_equal(summary_stats(c(NA, 10, NA))$missing, 2)
  expect_equal(summary_stats(c(8, 2, NA, NA, NA))$range, 6)
})

# Test rescale100()
context("rescale100")
test_that("rescale100 works", {
  expect_equal(rescale100(c(1, 2, 3, NA, 4), 0, 5), c(20, 40, 60, NA, 80))
  expect_equal(rescale100(c(5, 2, 13, 2, 4), 0, 100), c(5, 2, 13, 2, 4))
  expect_equal(rescale100(c(NA, 10, NA), 0, 10), c(NA, 100, NA))
  expect_equal(rescale100(c(8, 10, NA, NA, NA), 0, 10), c(80, 100, NA, NA, NA))
})

# Test drop_lowest()
context("drop_lowest")
test_that("drop_lowest works", {
  expect_equal(drop_lowest(c(1, 2, 3, NA, 4)), c(2,3, NA, 4))
  expect_equal(drop_lowest(c(5, 2, 13, 2, 4)), c(5, 13, 2, 4))
  expect_equal(drop_lowest(c(10,100)), c(100))
  expect_equal(drop_lowest(c(8, 10)), c(10))
})

# Test score_homework()
context("score_homework")
test_that("score_homework works", {
  expect_equal(score_homework(c(1, 2, 3, NA, 4), drop=TRUE), 3)
  expect_equal(score_homework(c(1, 2, 3, NA, 4), drop=FALSE), 10/4)
  expect_equal(score_homework(c(10,100), drop=FALSE), 110/2)
  expect_equal(score_homework(c(0, 8, 10), drop=TRUE), 9)
})

# Test score_quiz()
context("score_quiz")
test_that("score_quiz works", {
  expect_equal(score_quiz(c(1, 2, 3, NA, 4), drop=TRUE), 3)
  expect_equal(score_quiz(c(1, 2, 3, NA, 4), drop=FALSE), 10/4)
  expect_equal(score_quiz(c(10,100), drop=FALSE), 110/2)
  expect_equal(score_quiz(c(0, 8, 10), drop=TRUE), 9)
})

# Test score_lab()
context("score_lab")
test_that("score_lab works", {
  expect_equal(score_lab(12), 100)
  expect_equal(score_lab(11), 100)
  expect_equal(score_lab(7), 20)
  expect_equal(score_lab(5), 0)
})
