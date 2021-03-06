library(bit64)
source("euler/R/big_int.R")
source("euler/R/numbers.R")

compute <- function(n, modulo) {
    get_digits <- function(k, limit) {
        result <- list()
        if (k < 1) return(NULL)
        if (k <= limit) result <- c(result, k)
        for (i in 1:limit) for (j in get_digits(k - i, i)) result[[length(result) + 1]] <- c(i, j)
        return(result)
    }
    factorials <- list()
    all_digits <- (as.bigint(invmod(9, as.integer64(modulo))) * as.bigint(powmod(10, n, modulo) - 1)) %% modulo
    total <- as.bigint(0)
    for (digit in 1:9) {
        for (other_digits in get_digits(digit, digit)) {
            len_digits <- length(other_digits)
            if (n - len_digits - 1 < 0) next()
            digits <- table(c(digit, other_digits))
            for (m in names(digits)) {
                partial_digits <- digits
                partial_digits[m] <- partial_digits[m] - 1
                if (is.null(factorials[len_digits][[1]])) {
                    factorials[[len_digits]] <- as.bigint(1)
                    for (i in 0:(len_digits - 1)) factorials[[len_digits]] %*=% as.bigint(n - i - 1)
                }
                multinomial <- factorials[[len_digits]]
                for (p in partial_digits) multinomial <- multinomial %/% factorial(p)
                total <- total + all_digits * m * multinomial
            }
        }
        total <- total %% modulo
    }
    return(total)
}
