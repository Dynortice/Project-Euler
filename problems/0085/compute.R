compute <- function(n) {
    limit <- as.integer(sqrt(n))
    triangles <- 1
    for (i in 2:limit) {
        triangles[i] <- triangles[i - 1] + i
    }
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
            if (rectangles > n) {
                break
            }
        }
    }
    return(nearest)
}
