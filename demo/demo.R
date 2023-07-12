library(Robyn)
library(tidyverse)
select_model <- "1_87_5"
InputCollect <- readRDS("InputCollect.rds")
OutputCollect <- readRDS("OutputCollect.rds")

AllocatorCollect1 <- robyn_allocator(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  channel_constr_low = c(0.7, 0.7),
  channel_constr_up = c(1.2, 1.5),
  scenario = "max_response",
  export = create_files
)

# Print & plot allocator's output
print(AllocatorCollect1)
plot(AllocatorCollect1)

message(sprintf("Response: %s", "initResponseUnit"))

test = c(1,2)

names(c()) <- test

unlist(summarise_all(select(InputCollect$dt_input, any_of(InputCollect$paid_media_spends)), sum))

InputCollect$dt_input %>% rename(ds = InputCollect$date_var)
