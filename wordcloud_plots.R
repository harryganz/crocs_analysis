source('./review_analysis.R')
library(colorspace)

.brandnames = c("Nike", "Skechers", "Crocs")
for (i in seq_along(.brandnames)) {
  name = .brandnames[[i]]
  pal = qualitative_hcl(length(.brandnames), h = c(270, 150), l = 70, c = 50)
  png(paste("./figures/wordcloud_", name, ".png"), width = 8, height = 6, units = "in", res = 320)
  textplot_wordcloud(dfm_subset(review_dfm, brand == name), max_words = 100, color = pal[i])
  dev.off()
}