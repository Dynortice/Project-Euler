library(arrangements)

compute <- function() {
    result <- 0
    factorials <- factorial(0:9)
    for (i in 2:7) {
        combs <- combinations(0:9, i, replace = TRUE)
        for (j in seq_len(nrow(combs))) {
            candidate <- sum(factorials[combs[j,] + 1])
            digits <- sort(intToUtf8(utf8ToInt(as.character(candidate)), multiple = TRUE))
            if (length(digits) == i && all(digits == sort(combs[j,]))) result <- result + candidate
        }
    }
    return(result)
}