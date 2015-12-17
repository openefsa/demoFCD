library(dplyr)
source("drawMap.R")
vars <- c("Mean","STD","P5","P10")
data <- tbl_df(read.csv("./chronicgdaytotpop_L4.csv",skip=2)) %>%
    mutate_each_(funs(as.character(.)),vars) %>%
    mutate_each_(funs(gsub(",",".",.)),vars) %>%
    mutate_each_(funs(as.numeric(.)),vars)

getMapData <- function(foodex.l4) {     

    data %>% filter(Foodex.L4==foodex.l4) %>%
        group_by(Country) %>%
        select(Mean) %>%
        summarize(value=mean(Mean))
}
