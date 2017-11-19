# ===================================================================
# Title: Clean-Data-Script
# Description: Script to clean rawscores.csv
# Inputs: rawscores.csv
# Outputs: summary-rawscores.txt, summary-cleanscores.txt,
#          Lab-stats.txt, Homework-stats.txt, Quiz-stats.txt,
#          Test1-stats.txt, Test2-stats.txt, Overall-stats.txt
# Author: Yowsean Li
# Date: 11-13-2017
# ===================================================================

dat <- read.csv('../data/rawdata/rawscores.csv')

# Sink data summary
sink('../output/summary-rawscores.txt')
str(dat)
for (i in 1:length(dat)) {
  print(names(dat)[i])
  print_stats(summary_stats(dat[,i]))
}
sink()

# Replace NA with 0
for (col in names(dat)) {
  for (i in 1:length(dat[,col])) {
    if (is.na(dat[,col][i])) {
      dat[,col][i] <- 0
    }
  }
}

# Rescale quizzes and exams
dat$QZ1 <- rescale100(dat$QZ1, 0, 12)
dat$QZ2 <- rescale100(dat$QZ2, 0, 18)
dat$QZ3 <- rescale100(dat$QZ3, 0, 20)
dat$QZ4 <- rescale100(dat$QZ4, 0, 20)
dat$Test1 <- rescale100(dat$EX1, 0, 80)
dat$Test2 <- rescale100(dat$EX2, 0, 90)

hw_scores <- c()
qz_scores <- c()
lab_scores <- c()
for (i in 1:length(dat[,1])) {
  hw_scores <- c(hw_scores, score_homework(dat[i,1:9], drop=TRUE))
  qz_scores <- c(qz_scores, score_quiz(dat[i,11:14], drop=TRUE))
  lab_scores <- c(lab_scores, score_lab(dat[i, 10]))
}
dat$Homework <- hw_scores
dat$Quiz <- qz_scores
dat$Lab <- lab_scores

overall_scores <- c()
for (i in 1:length(dat[,1])) {
  total_sc <- .1*dat[i,'Lab']+.3*dat[i,'Homework']+.15*dat[i,'Quiz']+.2*dat[i,'Test1']+.25*dat[i,'Test2']
  overall_scores <- c(overall_scores, total_sc)
}
dat$Overall <- overall_scores

grade_to_letter <- function(grade) {
  if (grade >= 95) {
    'A+'
  } else if (grade >= 90) {
    'A'
  } else if (grade >= 88) {
    'A-'
  } else if (grade >= 86) {
    'B+'
  } else if (grade >= 82) {
    'B'
  } else if (grade >= 79.5) {
    'B-'
  } else if (grade >= 77.5) {
    'C+'
  } else if (grade >= 70) {
    'C'
  } else if (grade >= 60) {
    'C-'
  } else if (grade >= 50) {
    'D'
  } else {
    'F'
  }
}
letter_grades <- c()
for (i in 1:length(dat[,1])) {
  letter_grades <- c(letter_grades, grade_to_letter(dat[i,'Overall']))
}
dat$Grade <- letter_grades


for (i in c('Lab', 'Homework', 'Quiz', 'Test1', 'Test2', 'Overall')){
  sink(paste('../output/', paste(i, 'stats.txt', sep="-"), sep=''))
  print_stats(summary_stats(dat[,i]))
  sink()
}
summary_stats(dat[,'Homework'])

sink('../output/summary-cleanscores.txt')
str(dat)
sink()

write.csv(dat, '../data/cleandata/cleanscores.csv')
