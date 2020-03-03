source('./review_analysis.R')
source('./themes.R')
library(ggplot2)

kp1 <- satisfaction_keyness %>%
  ggplot(aes(x = reorder(feature, G2), y = G2)) +
  geom_bar(stat = "identity", aes(fill = ifelse(G2 > 0, "4-5 Stars", "0-3 Stars"))) +
  coord_flip() +
  scale_fill_discrete("Rating", h = c(260, 375), c = 360, l = 65) +
  scale_y_continuous("Log-Likelihood") +
  scale_x_discrete("Term") + 
  ggtitle("Key terms in Amazon reviews of athletic shoes") + 
  theme_default

ggsave("./figures/satsisfaction_keyterms.png", plot = kp1, height = 6, width = 8, units = "in", dpi = "retina")
  