library(rnaturalearthdata)
library(rnaturalearth)
library(tidyverse)
library(ggtext)
library(scales)
library(gt)

world <- ne_countries(scale = "medium", returnclass = "sf")

metadata_2024 <- metadata |>
  filter(year == 2024)

world |>
  left_join(metadata_2024, join_by(iso_a3_eh == iso3)) |>
  ggplot() +
  geom_sf(aes(fill = mcv2)) +
  scale_fill_gradient(low = "red",
                      high = "white",
                      limits = c(0, 1),
                      breaks = c(0, 0.5, 1),
                      labels = label_percent()) +
  labs(title = "2024 Measles Vaccination Rates Around the World",
       x = "",
       y = "",
       fill = "Measles Vaccination Rate",
       caption = "A map of the countries in the world colored by 2024 vaccination rates, where lighter red represents a higher vaccination rate and darker red represents a lower vaccination rate. Contries that are grayed out have unknown vaccination rates.",
       alt = "A world map displaying 2024 measles vaccination rates on a red color scale. Many countries in North America, Europe, and parts of Asia appear lighter, suggesting higher vaccination coverage, while several countries in central and sub-Saharan Africa are darker, suggesting lower coverage. Some countries are gray, representing unknown vaccination rates.") +
  theme_bw() +
  theme(plot.caption = element_textbox_simple(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank())

