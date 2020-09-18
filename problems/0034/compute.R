library(arrangements)

compute <- function() {
    result <- 0
    factorials <- factorial(0:9)
    for (i in 2:7) {
        combs <- combinations(0:9, i, replace = TRUE)
        for (j in seq_len(nrow(combs))) {
            candidate <- 0
            for (k in seq_len(i)) {
                candidate <- candidate + factorials[combs[j, k] + 1]
            }
            candidate_digits <- sort(as.integer(strsplit(as.character(candidate), NULL)[[1]]))
            if (length(candidate_digits) == i) {
                if (sum(candidate_digits == sort(combs[j,])) == i) {
                    result <- result + candidate
                }
            }
        }
    }
    return(result)
}