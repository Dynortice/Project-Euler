library(arrangements)

compute <- function(n) {
    max_len <- 2
    result <- 0
    while (nchar(as.character(max_len * 9 ^ n)) >= max_len) {
        combs <- combinations(0:9, max_len, replace = TRUE)
        for (i in seq_len(nrow(combs))) {
            candidate <- 0
            for (j in seq_len(max_len)) {
                candidate <- candidate + combs[i, j] ^ n
            }
            candidate_digits <- sort(as.integer(strsplit(as.character(candidate), NULL)[[1]]))
            if (length(candidate_digits) == max_len) {
                if (sum(candidate_digits == sort(combs[i,])) == max_len) {
                    result <- result + candidate
                }
            }
        }
        max_len <- max_len + 1
    }
    return(result)
}
