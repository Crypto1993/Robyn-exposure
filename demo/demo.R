library(Robyn)
select_model <- "1_87_5"
InputCollect <- readRDS("InputCollect.rds")
OutputCollect <- readRDS("OutputCollect.rds")

AllocatorCollect1 <- robyn_allocator(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  channel_constr_low = 0.7,
  channel_constr_up = c(1.2, 1.5),
  scenario = "max_response",
  export = create_files
)

# Print & plot allocator's output
print(AllocatorCollect1)
plot(AllocatorCollect1)
