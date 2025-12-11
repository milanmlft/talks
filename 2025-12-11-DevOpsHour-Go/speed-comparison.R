library(tidyverse)

# Data source: https://github.com/niklas-heer/speed-comparison
df <- read_tsv("data/speed-comparison.tsv")

# Reduce languages
selected_langs <- c(
  "C (gcc)",
  "C++ (g++)",
  "Julia (AOT compiled)",
  "Fortran 90",
  "Zig",
  "Rust",
  "Go",
  "Java",
  "C#",
  "Javascript (nodejs)",
  "Julia",
  "Python (PyPy)",
  "R",
  "Lua",
  "Ruby",
  "Perl"
)

df_reduced <- df |>
  filter(name %in% selected_langs) |>
  mutate(is_go = name == "Go")

p <- ggplot(
  df_reduced,
  aes(x = reorder(name, min, decreasing = TRUE), y = min)
) +
  geom_bar(aes(fill = is_go), stat = "identity") +
  geom_text(aes(label = round(min, 1)), hjust = -0.1, size = 3) +
  coord_flip() +
  scale_y_log10(limits = c(1, 3e4), expand = expansion(0, 0)) +
  labs(
    title = "Time to compute π through the Leibniz formula",
    x = NULL,
    y = "Minimum time (ms), in log scale",
    caption = "Data source: https://github.com/niklas-heer/speed-comparison"
  ) +
  scale_fill_discrete(
    palette = c("grey55", "#00ADD8")
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    panel.background = element_rect(fill = "transparent", colour = NA),
    panel.grid = element_blank(),
    plot.caption = element_text(size = 7, face = "italic")
  )

ggsave("figures/speed-comparison.png", p)
