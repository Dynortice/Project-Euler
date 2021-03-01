source("euler/R/grid.R")

compute <- function (triangle) max_path_sum(lapply(strsplit(strsplit(triangle, "\n")[[1]], " "), as.integer))
