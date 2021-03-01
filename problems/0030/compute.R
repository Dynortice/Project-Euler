library(arrangements)

compute <- function(n) {
    max_len <- 2
    result <- 0
    powers <- (0:9) ^ n
    while (nchar(as.character(max_len * 9 ^ n)) >= max_len) {
        combs <- combinations(0:9, max_len, replace = TRUE)
        for (i in seq_len(nrow(combs))) {
            candidate <- sum(powers[combs[i,] + 1])
            digits <- sort(intToUtf8(utf8ToInt(as.character(candidate)), multiple = TRUE))
            if (length(digits) == max_len && all(digits == sort(combs[i,]))) result <- result + candidate
        }
        max_len <- max_len + 1
    }
    return(result)
}
