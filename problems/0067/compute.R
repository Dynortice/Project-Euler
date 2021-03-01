source("euler/R/grid.R")

compute <- function(path) {
    triangle <- lapply(strsplit(gsub("\"", "", readLines(path, warn = FALSE)), " "), as.integer)
    return(max_path_sum(triangle))
}