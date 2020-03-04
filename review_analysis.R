library(tidyverse)
library(quanteda)
library(readr)

products <- read_csv('./data/products_2020-02-21.csv')
reviews <- read_csv('./data/reviews_2020-02-21.csv') %>% 
  mutate(satisfaction = ifelse(stars < 4, "unsatisfied", "satisfied"))

review_corpus <- corpus(reviews, text_field = "review")

review_dfm <- dfm(review_corpus, 
                  remove_numbers = TRUE, 
                  remove_symbols = TRUE, 
                  remove = c(stopwords("english"), "shoe", "shoes", "feet", "foot", "crocs", "croc", "nike's", "nikes", "nike", "skechers", "sketcher", "skecher", "sketchers"), 
                  remove_punct = TRUE) %>%
  dfm_trim(min_termfreq = 50) %>%
  dfm_remove("^[0-9]+$", valuetype = "regex") %>%
  dfm_remove("^[a-z]{1}$", valuetype = "regex")

brand_keyness <- as_tibble(do.call(rbind, lapply(c("Skechers", "Crocs", "Nike"), function(x) {
  cbind(brand = x, textstat_keyness(review_dfm, docvars(review_corpus, "brand") == x, measure = "lr"))
}))) %>% 
  select(-n_target, -n_reference) %>%
  group_by(brand) %>%
  arrange(desc(G2)) %>%
  filter(row_number() < 11) %>%
  ungroup() %>%
  arrange(brand, G2)

satisfaction_keyness <- as_tibble(do.call(rbind, lapply(c("satisfied"), function(x) {
  cbind(satisfaction = x, textstat_keyness(review_dfm, docvars(review_corpus, "satisfaction") == x, measure = "lr"))
})))%>% 
  select(-n_target, -n_reference) %>%
  group_by(satisfaction) %>%
  arrange(G2) %>%
  filter(row_number() < 11 | row_number() > (length(G2) - 10)) %>%
  ungroup() %>%
  arrange(satisfaction, G2)