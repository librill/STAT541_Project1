library(tidyverse)

dataset |>
  ggplot(aes(x = log(GDP_per_capita),
             y = log(measles_incidence_rate_per_1000000_total_population/1000000))) +
  geom_point() +
  labs(title = "GDP and Measles Incidence Association (log scale)",
       subtitle = "Log Measles Incidence Rate per Person",
       x = "Log GDP per Capita (international dollars)",
       y = "") +
  theme_bw()

dataset |>
  filter(year == 2024) |>
  group_by(country) |>
  summarize(avg_GDP = mean(GDP_per_capita, na.rm = TRUE),
            avg_measles = mean(measles_incidence_rate_per_1000000_total_population, na.rm = TRUE)) |>
  slice_max(avg_GDP, n = 10) |>
  gt() |>
  data_color(columns = avg_measles, method = "numeric", palette = "Greens") |>
  fmt_number(columns = prop_symptomatic_confirmed, decimals = 2) |>
  cols_align(align = "left", columns = month)
