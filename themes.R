library(ggplot2)
theme_default <- theme(
  panel.background = element_rect(fill = 'white', colour = "white"),
  panel.grid.major = element_line(color = "grey", size = 0.1),
  panel.grid.minor = element_blank(),
  axis.line.x = element_line(color = "black"),
  axis.line.y = element_line(color = "black"),
  axis.title = element_text(size = 12),
  plot.title = element_text(hjust = 0.5)
)
suppress_x_grid = theme(
  panel.grid.major.x = element_blank()
)
suppress_y_grid = theme(
  panel.grid.major.y = element_blank()
)