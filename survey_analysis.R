library(tidyverse)

survey_data <- read_csv('./data/survey_2020-02-24.csv')
questions <- read_csv('./data/question_lookup.csv')

.awareness <- function(x) {
  sum(!is.na(x))/length(x)*100
}

brand_awareness <- survey_data %>% 
  mutate(id = row_number()) %>%
  separate_rows(Q1, convert = TRUE) %>%
  separate_rows(Q2, convert = TRUE) %>%
  separate_rows(Q4, convert = TRUE) %>%
  select(id, Q1, Q2, Q4) %>% 
  gather(key = "Question", value = "Brand", Q1, Q2, Q4) %>%
  group_by(Question, Brand) %>%
  summarise(Awareness = length(unique(id))/nrow(survey_data) * 100) %>%
  mutate(Text = questions$Text[questions$Question %in% Question]) %>%
  arrange(Question, desc(Awareness))

purchase_importance <- survey_data %>%
  group_by(Q3) %>%
  summarise(Percent = length(Q3)/nrow(survey_data)*100)
names(purchase_importance)[1] <- questions$Text[3]