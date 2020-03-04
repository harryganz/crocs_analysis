library(tidyverse)
library(readr)

survey_data <- read_csv('./data/survey_2020-02-24.csv')
questions <- read_csv('./data/question_lookup.csv')

.sp <- function(p, N) {
  sqrt(p*(1-p)/N)
}

.margin <- function(p, N) {
  1.96*.sp(p, N) + 1/(2*N)
}

brand_awareness <- survey_data %>% 
  mutate(id = row_number()) %>%
  separate_rows(Q1, convert = TRUE) %>%
  separate_rows(Q2, convert = TRUE) %>%
  separate_rows(Q4, convert = TRUE) %>%
  select(id, Q1, Q2, Q4) %>% 
  gather(key = "Question", value = "Brand", Q1, Q2, Q4) %>%
  group_by(Question, Brand) %>%
  summarise(
    Awareness = round(length(unique(id))/nrow(survey_data) * 100, digits = 2),
    Margin = round(.margin(Awareness/100, nrow(survey_data))*100, digits = 1)
  ) %>%
  mutate(Text = questions$Text[questions$Question %in% Question]) %>%
  arrange(Question, desc(Awareness))

purchase_importance <- survey_data %>%
  group_by(Q3) %>%
  summarise(
    Percent = round(length(Q3)/nrow(survey_data)*100, digits = 2), 
    Margin = round(.margin(Percent/100, nrow(survey_data))*100, digits = 1)) %>%
  rename(`Which of the following is most important to you in selecting athletic footwear?` = Q3)