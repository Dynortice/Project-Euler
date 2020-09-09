compute <- function(n, grid) {
    grid <- strsplit(grid, "\n")[[1]]
    grid_numbers <- c()
    for (grid_line in grid) {
        grid_numbers <- c(grid_numbers, as.integer(strsplit(grid_line, " ")[[1]]))
    }
    width <- sqrt(length(grid_numbers))
    height <- sqrt(length(grid_numbers))
    grid_numbers <- matrix(grid_numbers, nrow = height, ncol = width)
    result <- 0
    grid_product <- function(coordinate, direction) {
        product <- 1
        for (i in 0:(n - 1)) {
            number <- grid_numbers[coordinate[2] + direction[2] * i,
                                   coordinate[1] + direction[1] * i]
            if (number == 0) {
                return(0)
            }
            product <- product * number
        }
        return(product)
    }
    for (y in 1:height) {
        for (x in 1:width) {
            if (x + n - 1 <= width) {
                result <- max(result, grid_product(c(x, y), c(1, 0)))
            }
            if (y + n - 1 <= height) {
                result <- max(result, grid_product(c(x, y), c(0, 1)))
                if (x + n - 1 <= width) {
                    result <- max(result, grid_product(c(x, y), c(1, 1)))
                }
                if (x - n >= 0) {
                    result <- max(result, grid_product(c(x, y), c(-1, 1)))
                }
            }
        }
    }
    return(result)
}
