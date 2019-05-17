library(plyr)
library(dplyr)
library(tidyr)
library(data.table)

getwd()
setwd("/Users/nicoshiro/Downloads")

fifa <- read.csv("fifa.csv")

fifa <- subset(fifa, fifa$Position != "GK")
fifa <- subset(fifa, fifa$Position != "")

fifa <- subset(fifa, select = c(Name, Age, Nationality, Overall, Club, Value, Preferred.Foot,
                                Weak.Foot, Skill.Moves, Position, Weight, Crossing, Finishing, 
                                HeadingAccuracy, ShortPassing, Volleys, Dribbling, Curve, FKAccuracy,
                                LongPassing, BallControl, Acceleration, SprintSpeed, Agility, Reactions,
                                Balance, ShotPower, Jumping, Stamina, Strength, LongShots, Aggression,
                                Interceptions, Positioning, Vision, Penalties, Composure, Marking,
                                StandingTackle, SlidingTackle))

fifa$SimplePosition[fifa$Position == "RWB"] <- "DEF"
fifa$SimplePosition[fifa$Position == "RCB"] <- "DEF"
fifa$SimplePosition[fifa$Position == "RB"] <- "DEF"
fifa$SimplePosition[fifa$Position == "LWB"] <- "DEF"
fifa$SimplePosition[fifa$Position == "LCB"] <- "DEF"
fifa$SimplePosition[fifa$Position == "LB"] <- "DEF"
fifa$SimplePosition[fifa$Position == "CB"] <- "DEF"

fifa$SimplePosition[fifa$Position == "RM"] <- "MID"
fifa$SimplePosition[fifa$Position == "RDM"] <- "MID"
fifa$SimplePosition[fifa$Position == "RCM"] <- "MID"
fifa$SimplePosition[fifa$Position == "RAM"] <- "MID"
fifa$SimplePosition[fifa$Position == "LM"] <- "MID"
fifa$SimplePosition[fifa$Position == "LDM"] <- "MID"
fifa$SimplePosition[fifa$Position == "LCM"] <- "MID"
fifa$SimplePosition[fifa$Position == "LAM"] <- "MID"
fifa$SimplePosition[fifa$Position == "CM"] <- "MID"
fifa$SimplePosition[fifa$Position == "CDM"] <- "MID"
fifa$SimplePosition[fifa$Position == "CAM"] <- "MID"

fifa$SimplePosition[fifa$Position == "ST"] <- "FWD"
fifa$SimplePosition[fifa$Position == "RW"] <- "FWD"
fifa$SimplePosition[fifa$Position == "RS"] <- "FWD"
fifa$SimplePosition[fifa$Position == "RF"] <- "FWD"
fifa$SimplePosition[fifa$Position == "LW"] <- "FWD"
fifa$SimplePosition[fifa$Position == "LS"] <- "FWD"
fifa$SimplePosition[fifa$Position == "LF"] <- "FWD"
fifa$SimplePosition[fifa$Position == "CF"] <- "FWD"


fifa$SimplePositionNum[fifa$SimplePosition == "DEF"] <- 1
fifa$SimplePositionNum[fifa$SimplePosition == "MID"] <- 2
fifa$SimplePositionNum[fifa$SimplePosition == "FWD"] <- 3


fifa_just_nums <- subset(fifa, select = c(SimplePositionNum, Weak.Foot, Skill.Moves, Crossing, Finishing, 
                                          HeadingAccuracy, ShortPassing, Volleys, Dribbling, Curve, FKAccuracy,
                                          LongPassing, BallControl, Acceleration, SprintSpeed, Agility, Reactions,
                                          Balance, ShotPower, Jumping, Stamina, Strength, LongShots, Aggression,
                                          Interceptions, Positioning, Vision, Penalties, Composure, Marking,
                                          StandingTackle, SlidingTackle))

write.csv(fifa_just_nums, "fifa_processed_FINAL.csv", row.names = FALSE)

