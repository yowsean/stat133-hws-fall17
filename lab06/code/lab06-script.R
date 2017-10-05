# ===================================================================
# Title: Lab 6 Script
# Description: Various commands
# Input(s): data file 'nba2017-players.csv'
# Output(s): Outputs for data structure, summary of warriors and lakers
# Author: Yowsean Li
# Date: 10-05-2017
# ===================================================================

# packages
library(readr)    # importing data
library(dplyr)    # data wrangling
library(ggplot2)  # graphics

dat <- read_csv('../data/nba2017-players.csv')
warriors <- arrange(filter(dat, team == 'GSW'), salary)
write.csv(warriors, '../data/warriors.csv', row.names=FALSE)
lakers <- arrange(filter(dat, team == 'LAL'), desc(experience))
write_csv(lakers, '../data/lakers.csv')

sink(file = '../output/data-structure.txt')
str(dat)
sink()

sink(file = '../output/summary-warriors.txt')
summary(warriors)
sink()

sink(file = '../output/summary-lakers.txt')
summary(lakers)
sink()

png(filename = "../images/scatterplot-height-weight.png")
plot(dat$height, dat$weight, pch = 20, 
     xlab = 'Height', ylab = 'Weight')
dev.off()

png(filename = "../images/scatterplot-height-weight-HIRES.png", res = 100)
plot(dat$height, dat$weight, pch = 20,
     xlab = 'Height', ylab = 'Weight')
dev.off()

jpeg(filename = "../images/histogram-age.jpeg", width = 600, height = 400)
hist(dat$age, xlab='Age', main='Histogram of Ages')
dev.off()

pdf('../images/histogram-age.pdf', width = 7, height = 5)
hist(dat$age, xlab='Age', main='Histogram of Ages')
dev.off()

gg_pts_salary <- ggplot(data = dat, aes(x=points, y=salary)) +
  geom_point()
ggsave('../images/points_salary.pdf', gg_pts_salary, width = 7, height = 5)

gg_ht_wt_position <- ggplot(data = dat, aes(x=height, y=weight)) +
  geom_point() +
  facet_wrap(~position)
ggsave('../images/height_weight_by_position.pdf', gg_ht_wt_position, width = 6, height = 4)

lakers %>%
  select(player)

warriors %>%
  filter(position == 'PG') %>%
  select(player, salary)

dat %>%
  filter(experience > 10) %>%
  filter(salary <= 10000000) %>%
  select(player, age, team)

gsw_mpg <- warriors %>%
  mutate(min_per_game = minutes/games) %>%
  select(player, experience, min_per_game) %>%
  arrange(desc(min_per_game))

dat %>%
  group_by(team) %>%
  summarize(triple_pct=mean(points3)) %>%
  arrange(triple_pct) %>%
  slice(0:6)

mean(filter(dat, experience == 5 | experience == 10)$age)

sd(filter(dat, experience == 5 | experience == 10)$age)
