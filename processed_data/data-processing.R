rm(list = ls())
library(tidyverse)
library(ggplot2)
library(plotly)
library(ggthemes)
library(rstudioapi) 

setwd(dirname(getActiveDocumentContext()$path))

# File name
file_name = "TURKEY_TEST_2021_v02.xlsx"

# Read xlsx document
df <- readxl::read_excel(paste0("~/crop-classification-accuracy/raw_data/", file_name))

city_index <- starts_with(match = "City", vars = colnames(df))
time_index <- starts_with(match = "Pro", vars = colnames(df))

if(colnames(df)[time_index] == "ProcessIdP1"){
  colnames(df)[time_index] <- "ProcessIdP3"
}

if(colnames(df)[city_index] == "CityNameTr"){
  colnames(df)[city_index] <- "CityNameEng"
}  


df <- df %>% 
  janitor::clean_names() %>% 
  rename(true_value = process_id,
         prediction = majority) %>% 
  select(id, region_name_eng, city_name_eng, true_value, prediction)

df$id = as.numeric(df$id)
df$true_value = as.numeric(df$true_value)
df$prediction = as.numeric(df$prediction)

df <- df %>% 
  mutate(true_value = case_when(true_value == 41 ~ "Wheat",
                                true_value == 12 ~ "Sunflower",
                                true_value == 13 ~ "Pepper",
                                true_value == 14 ~ "Rice",
                                true_value == 15 ~ "Tomato",
                                true_value == 16 ~ "Watermelon",
                                true_value == 17 ~ "Melon",
                                true_value == 18 ~ "Corn",
                                true_value == 19 ~ "Sugarbeet", 
                                true_value == 21 ~ "Alfalfa",
                                true_value == 24 ~ "Cotton",
                                true_value == 25 ~ "Bean",
                                true_value == 28 ~ "Potato",
                                true_value == 32 ~ "Vegetation",
                                true_value == 51 ~ "Canola", 
                                true_value == 52 ~ "Onion",
                                true_value == 56 ~ "Lentil",
                                true_value == 58 ~ "Chickpea",
                                true_value == 62 ~ "Squash",
                                true_value == 66 ~ "Tobacco",
                                true_value == 72 ~ "Vineyard",
                                true_value == 96 ~ "Orchard",
                                true_value == 97 ~ "NotField",
                                true_value == 98 ~ "Other",
                                true_value == 99 ~ "Agricultural_Soil",
                                true_value == 105 ~ "Olive",
                                true_value == 116 ~ "Citrus")) %>% 
  mutate(prediction = case_when(prediction == 41 ~ "Wheat",
                                prediction == 12 ~ "Sunflower",
                                prediction == 13 ~ "Pepper",
                                prediction == 14 ~ "Rice",
                                prediction == 15 ~ "Tomato",
                                prediction == 16 ~ "Watermelon",
                                prediction == 17 ~ "Melon",
                                prediction == 18 ~ "Corn",
                                prediction == 19 ~ "Sugarbeet", 
                                prediction == 21 ~ "Alfalfa",
                                prediction == 24 ~ "Cotton",
                                prediction == 25 ~ "Bean",
                                prediction == 28 ~ "Potato",
                                prediction == 32 ~ "Vegetation",
                                prediction == 51 ~ "Canola", 
                                prediction == 52 ~ "Onion",
                                prediction == 56 ~ "Lentil",
                                prediction == 58 ~ "Chickpea",
                                prediction == 62 ~ "Squash",
                                prediction == 66 ~ "Tobacco",
                                prediction == 72 ~ "Vineyard",
                                prediction == 96 ~ "Orchard",
                                prediction == 97 ~ "NotField",
                                prediction == 98 ~ "Other",
                                prediction == 99 ~ "Agricultural_Soil",
                                prediction == 105 ~ "Olive",
                                prediction == 116 ~ "Citrus"))

save(list = "df", file = "~/crop-classification-accuracy/processed_data/df.RDS")
