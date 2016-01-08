# Converts the relational tables created by jq/tables.sh into a list of
# data.frames for analysis using R

library(readr)

item_csvs <- list.files("../jq/items", pattern = "*.csv", full.names = TRUE)
names(item_csvs) <- paste0("item_", gsub("\\.csv", "", list.files("../jq/items", pattern = "*.csv", full.names = FALSE)))
coll_csvs <- list.files("../jq/collections", pattern = "*.csv", full.names = TRUE)
names(coll_csvs) <- paste0("coll_", gsub("\\.csv", "", list.files("../jq/collections", pattern = "*.csv", full.names = FALSE)))

csvs <- c(item_csvs, coll_csvs)

nypl <- lapply(as.list(csvs), function(x) {
  read_csv(file = x)
})

View(nypl$contributorRoles)

save(nypl, file = "nypl.rda")

