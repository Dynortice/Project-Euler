library(arrangements)

compute <- function(n) {
    sum_squares_digits <- function(x) {
        return(sum(as.integer(strsplit(x, NULL)[[1]]) ^ 2))
    }

    result <- 0
    combs <- combinations(0:9, n, replace = TRUE)
    for (i in seq_len(nrow(combs))) {
        combination <- paste0(combs[i,], collapse = "")
        while (TRUE) {
            combination <- sum_squares_digits(combination)
            if (combination == 89) {
                result <- result + factorial(n) / prod(factorial(table(combs[i, ])))
                break
            } else if (combination < 2) {
                break
            } else {
                combination <- as.character(combination)
            }
        }
    }
    return(result)
}