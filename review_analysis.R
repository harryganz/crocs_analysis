library(quanteda)

products <- read_csv('./data/products_2020-02-21.csv')
reviews <- read_csv('./data/reviews_2020-02-21.csv') %>% 
  mutate(satisfaction = ifelse(stars < 4, "unsatisfied", "satisfied"))

review_corpus <- corpus(reviews, text_field = "review")

review_dfm <- dfm(review_corpus, remove = c(stopwords("english"), "shoe", "shoes", "feet", "foot", "crocs", "croc", "nike's", "nikes", "nike", "skechers", "sketcher", "skecher", "sketchers"), remove_punct = TRUE)

brand_keyness <- as_tibble(do.call(rbind, lapply(c("Skechers", "Crocs", "Nike"), function(x) {
  cbind(brand = x, textstat_keyness(review_dfm, docvars(review_corpus, "brand") == x, measure = "lr"))
})))
satisfaction_keyness <- as_tibble(do.call(rbind, lapply(c("satisfied", "unsatisfied"), function(x) {
  cbind(satisfaction = x, textstat_keyness(review_dfm, docvars(review_corpus, "satisfaction") == x, measure = "lr"))
})))