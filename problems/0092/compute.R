source("euler/R/numbers.R")
library(arrangements)

compute <- function(n) {
    squares <- 0:9 * 0:9
    result <- 0
    combs <- combinations(0:9, n, replace = TRUE)
    for (i in seq_len(nrow(combs))) {
        combination <- as.integer(paste0(combs[i,], collapse = ""))
        while (TRUE) {
            combination <- sum(squares[get_digits(combination) + 1])
            if (combination == 89) {
                result <- result + factorial(n) / prod(factorial(table(combs[i, ])))
                break
            } else if (combination < 2) {
                break
            }
        }
    }
    return(result)
}