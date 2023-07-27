library(Robyn)
library(tidyverse)


select_model <- "1_23_2"
InputCollect <- readRDS("input_collect.rds")
OutputCollect <- readRDS("OutputCollect.rds")
create_files <- TRUE
AllocatorCollect1 <- robyn_allocator(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  date_range = "last_52",
  channel_constr_low = 0.95,
  channel_constr_up = 1.05,
  scenario = "max_response",
  export = create_files
)


robyn_onepagers(InputCollect = InputCollect, OutputCollect = OutputCollect, select_model = select_model)

# Print & plot allocator's output
print(AllocatorCollect1)
plot(AllocatorCollect1)

message(sprintf("Response: %s", "initResponseUnit"))

test = c(1,2)

names(c()) <- test
unlist(summarise_all(select(InputCollect$dt_input, any_of(InputCollect$paid_media_spends)), sum))
InputCollect$dt_input %>% rename(ds = InputCollect$date_var)


j_data <- jsonlite::fromJSON("~/MMM/Robyn_202307072222_init/RobynModel-inputs.json", simplifyVector = F)

j_data$InputCollect$hyperparameters

InputCollect$hyperparameters <- j_data$InputCollect$hyperparameters



OutputCollect$xDecompVecCollect %>%
  left_join(
    InputCollect$dt_input %>% 
      rename(ds = week_end_date) %>% 
      select(ds, onl_sms_inv)
  ) %>% 
  filter(solID == select_model) %>% 
  tail(52) %>% 
  summarise(
    total_tv_con = sum(onl_sms_lea),
    total_tv_spent = sum(onl_sms_inv),
    roi = total_tv_con / total_tv_spent
  )



  