# ===================================================================
# Title: Make Teams Table
# Description: Create 'nba2017-teams.csv' which contains variables
#              needed for ranking
# Input(s): data files 'nba2017-roster.csv', 'nba2017-stats.csv'
# Output(s): data file 'nba2017-teams.csv'
# Author: Yowsean Li
# Date: 10-05-2017
# ===================================================================
# packages
library(readr)    # importing data
library(dplyr)    # data wrangling
library(ggplot2)  # graphics

roster <- read_csv('../data/nba2017-roster.csv')
stats <- read_csv('../data/nba2017-stats.csv')

# adding new variables
stats <- mutate(stats,
                missed_fg=field_goals_atts-field_goals_made,
                missed_ft=points1_atts-points1_made,
                points=points3_made*3+points2_made*2+points1_made,
                rebounds=off_rebounds+def_rebounds,
                efficiency=(points+rebounds+assists+steals+blocks
                            -missed_fg-missed_ft-turnovers)/games_played
                  )

sink(file = '../output/efficiency_summary.txt')
summary(stats$efficiency)
sink()

roster_stats <- merge(roster, stats)
teams <- roster_stats %>%
  group_by(team) %>%
  summarise(
    experience=sum(experience),
    salary=sum(salary)/1000000,
    points3=sum(points3_made),
    points2=sum(points2_made),
    free_throws=sum(points1_made),
    points=points3*3+points2*2+free_throws,
    off_rebounds=sum(off_rebounds),
    def_rebounds=sum(def_rebounds),
    assists=sum(assists),
    steals=sum(steals),
    blocks=sum(blocks),
    turnovers=sum(turnovers),
    fouls=sum(fouls),
    efficiency=sum(efficiency)
  )

sink(file = '../data/teams-summary.txt')
summary(team)
sink()

write_csv(teams, '../data/nba2017-teams.csv')

pdf('../images/teams_star_plot.pdf')
stars(teams[,-1], labels=teams$team)
dev.off()

pdf('../images/experience_salary.pdf')
ggplot(data = teams, aes(x=experience, y=salary)) +
  geom_point() + 
  geom_text(aes(label=team),hjust=0, vjust=0, size=3)
dev.off()