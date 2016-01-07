# Converts the relational tables created by jq/tables.sh into a list of
# data.frames for analysis using R

library(readr)

csvs <- list.files("../jq/", pattern = "*.csv", full.names = TRUE)
names(csvs) <- gsub("\\.csv", "", list.files("../jq/", pattern = "*.csv", full.names = FALSE))

nypl <- lapply(as.list(csvs), function(x) {
  read_csv(file = x)
})

View(nypl$contributorRoles)

save(nypl, file = "nypl.rda")

