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
  geom_point(color = "#f39c12") +
  scale_x_continuous(labels = label_percent()) +
  labs(title = "Proportion of Confirmed Measles Cases by Region",
       x = "Percent of Total Measles Cases that are Confirmed (%)",
       y = "",
       caption = md("**Figure X** The proportion of lab confirmed and epidemiologically linked measles cases to total cases, calculated across world regions"),
       alt = "A lollipop plot displaying the percent of total meales cases that are confirmed by region. Americas has the highest percentage with nearly all total measles cases confirmed. Eastern Mediterranean and South East Asia have the lowest percentages at just below 50%.") +
  theme_bw() +
  theme(plot.caption = element_textbox_simple())

# **Figure X** shows that the Americas with a near 100% confirmation rate. This suggests a very strong diagnostic infrastructure where almost every suspected case is officially verified. The Eastern Mediterranean and South East Asia regions show the lowest proportions, with both falling just under the 50% mark. This means that more than half of the measles cases in these regions remain unconfirmed by lab or epidemiological links

metadata |>
  filter_out(is.na(region)) |>
  group_by(region) |>
  summarize(mean_GDP = mean(GDP_per_capita, na.rm = TRUE),
            mean_mcv2 = mean(mcv2, na.rm = TRUE)) |>
  arrange(mean_GDP) |>
  gt() |>
  data_color(columns = mean_GDP, method = "numeric",
             fn = col_numeric(palette = c("#ecf0f1", "#3498db"),
                              domain = NULL)) |>
  data_color(columns = mean_mcv2, method = "numeric",
             fn = col_numeric(palette = c("#ecf0f1", "#29c1a3"),
                              domain = NULL)) |>
  fmt_currency(columns = mean_GDP, currency = "USD") |>
  fmt_percent(columns = mean_mcv2, decimals = 1) |>
  cols_align(align = "left", columns = region) |>
  tab_style(style = cell_text(weight = "bold"),
            locations = cells_column_labels()) |>
  tab_header(title = md("Average GDP per Capita and MCV2 Vaccine Rate by Region")) |>
  tab_caption(caption = md("**Table X** ")) |>
  cols_label(region = "Region", mean_GDP = "Mean GDP (USD)", mean_mcv2 = "Mean MCV2 Rate")

# **Table X** shows that a higher average region GDP is generally associated with a higher measles vaccination rate (with the exception of South East Asia, which has the second-lowest mean GDP but the second-highest MCV2 rate). Africa has the lowest GDP and the lowest MCV2, while Europe has the highest in both.

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
       caption = md("**Figure X** A map of the countries in the world colored by 2024 vaccination rates, where lighter red represents a higher vaccination rate and darker red represents a lower vaccination rate. Contries that are grayed out have unknown vaccination rates."),
       alt = "A world map displaying 2024 measles vaccination rates on a red color scale. Many countries in North America, Europe, and parts of Asia appear lighter, suggesting higher vaccination coverage, while several countries in central and sub-Saharan Africa are darker, suggesting lower coverage. Some countries are gray, representing unknown vaccination rates.") +
  theme_bw() +
  theme(plot.caption = element_textbox_simple(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank())

# **Figure X** shows that many countries in North America, Europe, and parts of Asia have higher vaccination coverage, while several countries in central and sub-Saharan Africa have lower coverage.
# ADD COMPARISON TO TABLE, TALK ABOUT WHAT THE GDP IS FOR THESE REGIONS? OR MAYBE THE MEASLES RATE

# Colors
  # "#29c1a3"
  # "#ecf0f1"
  # "#3498db"
  # "#f39c12"
  # "#e74c3c"
  # "#859394"
