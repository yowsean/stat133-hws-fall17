# test script
library(testthat)

# source in functions to be tested
source('functions.R')

#sink('../output/test-reporter.txt')
test_file('test.R')
#sink()

