source("euler/R/math.R")

compute <- function(grid) {
    edge <- nrow(grid)
    for (i in (edge - 1):1) {
        grid[edge, i] <- grid[edge, i] + grid[edge, i + 1]
        grid[i, edge] <- grid[i, edge] + grid[i + 1, edge]
    }
    for (i in (edge - 1):1) for (j in (edge - 1):1) grid[i, j] <- grid[i, j] + fast_min(grid[i + 1, j], grid[i, j + 1])
    return(grid[1, 1])
}
