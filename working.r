library(tidyverse)
library(rvest)
library(janitor)

getwd()

grandparents_local <- read_csv("data/grandparentsR1.csv")

# Pulling data from the web
grandparents_url <- 'https://raw.githubusercontent.com/rtburg/NICAR2020-Intro-to-R/master/data/grandparentsR1.csv'

grandparents_download <- read_csv(grandparents_url)

# Scraping 
https://github.com/rtburg/NICAR2020-Intro-to-R/blob/master/data/grandparentsR1.csv

grandparents_scrape <- read_html('https://github.com/rtburg/NICAR2020-Intro-to-R/blob/master/data/grandparentsR1.csv') %>%
  html_nodes('table') %>%
  html_table(header=1) %>%
  as.data.frame() %>%
  select(-1)

grandparents_local <- grandparents_local %>%
  clean_names()

grandparents_local <- grandparents_local %>%
  mutate(geography_copy = geography) %>%
  separate(geography, into=c("parish_name", "state"), sep=",")

grandparents_local <- grandparents_local %>%
  mutate(state = str_trim(state))

grandparents_local <- grandparents_local %>%
  mutate(parish_name = str_remove(parish_name, "Parish")) 

grandparents_local <- grandparents_local %>%
  mutate(parish_name = str_trim(parish_name))

glimpse(grandparents_local)

grandparents_local <- grandparents_local %>%
  mutate(id2 = as.character(id2))
glimpse(grandparents_local)

grandparents_local <- grandparents_local %>%
  mutate(state_code = str_sub(id2, start=1L, end=2L))

grandparents_local <- grandparents_local %>%
  mutate(county_code = str_sub(id2, start=3L, end=5L))

22005




