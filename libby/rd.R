library(scales)

# graph for RQ1 - plot of symptomatic vs confirmed cases by region
metadata |>
  filter_out(is.na(region)) |>
  group_by(region) |>
  summarize(confirmed_cases = sum(measles_epi_linked + measles_lab_confirmed),
            prop_confirmed = confirmed_cases/sum(measles_total)) |>
  mutate(region = fct_reorder(region, prop_confirmed)) |>
  ggplot(aes(x = prop_confirmed, y = region)) +
  geom_segment(aes(x = 0, xend = prop_confirmed)) +
  geom_point(color = "#3498db") +
  scale_x_continuous(labels = label_percent()) +
  labs(title = "Proportion of Total Measles Cases that are Confirmed, by Region",
       subtitle = "",
       x = "",
       y = "",
       caption = "") +
  theme_bw()

# table for RQ2 - table of GDP to vaccination rate for region
calculate_region_info <- function(input_region) {
  if (!is.character(input_region) & !is.factor(input_region)) {
    stop("Region should be a string")
  }
  if (!(input_region %in% unique(metadata$region))) {
    stop("Region not listed")
  }
  
  metadata |>
    filter(region == input_region) |>
    summarize(mean_mcv2 = mean(mcv2, na.rm = TRUE)) |>
    pull()
}

metadata |>
  distinct(region) |>
  filter_out(is.na(region)) |>
  mutate(mean_mcv2 = map_dbl(region, calculate_region_info)) |>
  arrange(mean_mcv2) |>
  gt() |>
  data_color(columns = mean_mcv2, method = "numeric",
             fn = col_numeric(palette = c("#ecf0f1", "#29c1a3"),
                                  domain = NULL)) |>
  fmt_number(columns = mean_mcv2, decimals = 2) |>
  cols_align(align = "left", columns = region) |>
  tab_style(style = cell_text(weight = "bold"),
            locations = cells_column_labels()) |>
  tab_header(title = md("Ratios of GDP per Capita to MCV2 Vaccine Rate")) |>
  tab_caption(caption = md("**Table X** ")) |>
  cols_label(region = "Region", mean_mcv2 = "GDP/MCV2 Proportion")

# graph for RQ2 - map
world <- ne_countries(scale = "medium", returnclass = "sf")

metadata_2024 <- metadata |>
  filter(year == 2024)

world |>
  left_join(metadata_2024, join_by(iso_a3_eh == iso3)) |>
  ggplot() +
  geom_sf(aes(fill = mcv2)) +
  scale_fill_gradient(low = "#e74c3c",
                      high = "#ecf0f1",
                      limits = c(0, 1),
                      breaks = c(0, 0.5, 1),
                      labels = label_percent()) +
  labs(title = "2024 Measles Vaccination Rates Around the World",
       x = "",
       y = "",
       fill = "Measles Vaccination Rate",
       caption = md("**Figure 3** A map of the countries in the world colored by 2024 vaccination rates, where lighter red represents a higher vaccination rate and darker red represents a lower vaccination rate. Contries that are grayed out have unknown vaccination rates."),
       alt = "A world map displaying 2024 measles vaccination rates on a red color scale. Many countries in North America, Europe, and parts of Asia appear lighter, suggesting higher vaccination coverage, while several countries in central and sub-Saharan Africa are darker, suggesting lower coverage. Some countries are gray, representing unknown vaccination rates.") +
  theme_bw() +
  theme(plot.caption = element_textbox_simple(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank())

"#29c1a3"
"#ecf0f1"
"#3498db"
"#f39c12"
"#e74c3c"
"#859394"
