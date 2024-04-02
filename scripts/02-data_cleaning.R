#### Preamble ####
# Purpose: Cleans Holocaust data
# Author: Krishiv Jain
# Date: 31 March 2024
# Contact: krishiv.jain@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(here)

#### Clean data ####
raw_data <- read_csv("Auschwitz_Death_Certificates_1942-1943 - Auschwitz.csv")

#### Save Data ####
write_csv(cleaned_data, "cleaned_data.csv")

residence_data <- group_by(cleaned_data, residence)|>
  summarise(number = n()) |>
  arrange(desc(number)) |>
  top_n(25)