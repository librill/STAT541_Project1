library(tidyverse)
library(gt)

tuesdata <- tidytuesdayR::tt_load('2025-06-24')
cases_month <- tuesdata$cases_month

calculate_2024_prop_sc <- function(input_month) {
  cases_month |>
    filter(year == 2024,
           month == input_month) |>
    summarize(symptomatic = sum(measles_suspect + measles_clinical,
                                na.rm = TRUE),
              confirmed = sum(measles_epi_linked + measles_lab_confirmed,
                              na.rm = TRUE),
              prop = symptomatic / confirmed) |>
    select(prop) |>
    pull()
}

cases_month |>
  filter(year == 2024) |>
  distinct(month) |>
  mutate(prop_symptomatic_confirmed = map_dbl(month, calculate_2024_prop_sc),
         month = month(month, label = TRUE, abbr = FALSE)) |>
  gt() |>
  data_color(columns = prop_symptomatic_confirmed, method = "numeric",
             palette = "Greens") |>
  fmt_number(columns = prop_symptomatic_confirmed, decimals = 2) |>
  cols_align(align = "left", columns = month) |>
  tab_style(style = cell_text(weight = "bold"),
            locations = cells_column_labels()) |>
  tab_header(title = md("2024 Ratios of Symptomatic to Confirmed Measles Cases")) |>
  tab_caption(caption = md("**Fig X.** Summary table visualizing how ratios
                           change from overall for the year 2024")) |>
  cols_label(month = "Month",
             prop_symptomatic_confirmed = "Symptomatic/Confirmed Proportion")


