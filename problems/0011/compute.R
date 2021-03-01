source("euler/R/grid.R")
source("euler/R/math.R")

compute <- function(n, grid) {
    grid <- lapply(strsplit(grid, "\n")[[1]], function (x) as.integer(strsplit(x, " ")[[1]]))
    width <- sqrt(length(grid_numbers)); height <- sqrt(length(grid_numbers))
    grid <- matrix(unlist(grid), nrow = height, ncol = width)
    result <- 0
    for (y in seq_len(height)) {
        for (x in seq_len(width)) {
            if (x + n - 1 <= width) result <- fast_max(result, adjacent_product(grid, n, c(x, y), c(1, 0)))
            if (y + n - 1 <= height) {
                result <- fast_max(result, adjacent_product(grid, n, c(x, y), c(0, 1)))
                if (x + n - 1 <= width) result <- fast_max(result, adjacent_product(grid, n, c(x, y), c(1, 1)))
                if (x - n >= 0) result <- fast_max(result, adjacent_product(grid, n, c(x, y), c(-1, 1)))
            }
        }
    }
    return(result)
}
