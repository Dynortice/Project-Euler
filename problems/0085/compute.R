source("euler/R/calculus.R")

compute <- function(n) {
    limit <- as.integer(sqrt(n))
    triangles <- triangular_numbers(limit)
    min_difference <- n
    nearest <- 0
    for (i in seq_len(limit)) {
        for (j in seq_len(i)) {
            rectangles <- triangles[i] * triangles[j]
            difference <- abs(n - rectangles)
            if (difference < min_difference) {
                min_difference <- difference
                nearest <- i * j
            }
            if (rectangles > n) break
        }
    }
    return(nearest)
}
