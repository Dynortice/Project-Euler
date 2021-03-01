compute <- function(n, limit) {
    result <- 0
    for (i in seq_len(n)) {
        for (j in seq_len(i %/% 2)) {
            if (choose(i, j) > limit) {
                result <- result + i - 2 * j + 1
                break
            }
        }
    }
    return(result)
}
