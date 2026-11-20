#About the dataset: 
#The Effect of Vitamin C on Tooth Growth in Guinea Pigs:
#The response is the length of odontoblasts (cells responsible for tooth growth) in 60 guinea pigs.
#Each animal received one of three dose levels of vitamin C (0.5, 1, and 2 mg/day)
#by one of two delivery methods, orange juice or ascorbic acid (a form of vitamin C and coded as VC).

#load packages
install.packages(
  c("ggplot2", "dplyr", "tidyr", "stringr"),
  repos = "https://cloud.r-project.org"
)

library(ggplot2)
library(dplyr)
library(tidyr)
library(stringr)

# Read command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Stop message
if (length(args)!=1) {
  stop("Please enter an output file name", call. = FALSE)
}

output_file_name <- args[1]


#Graph
tooth_data <- datasets::ToothGrowth

tooth_plot <- tooth_data |>
  ggplot(aes(x = dose, y = len, fill = supp, group = interaction(supp, dose))) +
  geom_boxplot(position = "dodge2") + 
  labs(x = "Dose (mg/day)", y = "Tooth length (mm)",
       title = "Effect of vitamin C on tooth growth in guinea pigs", 
       subtitle = str_wrap("Exploring the effect of different doses and supplement types of vitamin C on the tooth growth of 60 guinea pigs", width = 100),
       caption = str_wrap("Designed by Tomás Roque-Matta | R Database: ToothGrowth")
  ) +
  scale_fill_discrete(name = "Supplement type", labels = c("Orange juice", "Ascorbic acid")) + 
  theme_classic() +
  theme(
    plot.background = element_rect(fill = "#EAF4FA", colour = NA),
    panel.background = element_rect(fill = "grey95", colour = NA),
    legend.background = element_rect(fill = "#EAF4FA", colour = NA),
    plot.title = element_text(
      face = "bold", size = 19, colour = "darkblue", hjust = 0, 
      lineheight = 1.1, margin = margin(b = 10)
    ),
    plot.subtitle = element_text(
      size = 10, colour = "grey30", lineheight = 1.3, hjust = 0, 
      margin = margin(b = 22)
    ),
    plot.caption = element_text(
      size = 8, colour = "grey50", hjust = 0,
      lineheight = 1.3, margin = margin(t = 20)
    ),
    plot.caption.position = "plot",
    plot.title.position = "plot",
    plot.margin = margin(32, 32, 24, 32),
  )

#Save
ggsave(
  filename = output_file_name,
  plot = tooth_plot,
  units = "px",
  dpi = 300
)

  
  