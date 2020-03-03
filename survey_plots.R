source('./survey_analysis.R')
source('./themes.R')
p1 <- ggplot(purchase_importance, aes(x = `Which of the following is most important to you in selecting athletic footwear?`, y = Percent)) +
  geom_bar(stat = "identity", fill = "blue") +
  # geom_errorbar(
  #   aes(ymin = ifelse(Percent - Margin > 0, Percent - Margin, 0), ymax = ifelse(Percent + Margin < 100, Percent + Margin, 100)), 
  #   width = 0.2, 
  #   position = position_dodge(0.9)) + 
  scale_y_continuous(limits = c(0, 100), expand = c(0,0)) +
  ggtitle("Which of the following is most important to you in selecting athletic footwear?") + 
  theme(axis.title.x = element_blank()) +
  theme_default + suppress_x_grid
p2 <- brand_awareness %>% 
  dplyr::rename(Percent = Awareness) %>% 
  transform(Text = factor(Text, levels = unique(Text[order(Question)]))) %>%
  ggplot(aes(x = Brand, y = Percent)) +
  geom_bar(stat = "identity", fill = "blue") + 
  # geom_errorbar(
  #   aes(ymin = ifelse(Percent - Margin > 0, Percent - Margin, 0), ymax = ifelse(Percent + Margin < 100, Percent + Margin, 100)), 
  #   width = 0.2, 
  #   position = position_dodge(0.9)) +
  scale_y_continuous(limits = c(0, 100), expand = c(0,0)) +
  facet_wrap(vars(Text), nrow = 3) +
  theme_default + suppress_x_grid

ggsave("./figures/purchase_decision.png", p1, height = 6, width = 8, units = "in", dpi = "retina")
ggsave("./figures/brand_awareness.png", p2, height = 6, width = 8, units = "in", dpi = "retina")