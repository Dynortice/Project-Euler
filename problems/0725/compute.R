source("euler/R/big_int.R")
source("euler/R/numbers.R")

compute <- function(n, modulo) {
    digit_sum <- function(k, limit) {
        result <- list()
        if (k < 1) {
            return(NULL)
        }
        if (k <= limit) {
            result <- c(result, k)
        }
        for (i in 1:limit) {
            for (j in digit_sum(k - i, i)) {
                result[[length(result) + 1]] <- c(i, j)
            }
        }
        return(result)
    }
    reverted_factorial <- function(k) {
        if (is.null(factorials[k][[1]])) {
            result <- as.bigint(1)
            for (i in 0:(k - 1)) {
                result %*=% (n - i - 1)
            }
            factorials[[k]] <<- result
        }
        return(factorials[[k]])
    }
    factorials <- list()
    all_digits <- (as.bigint(invmod(9, modulo)) * as.bigint(powmod(10, n, modulo) - 1)) %% modulo
    total <- as.bigint(0)
    for (digit in 1:9) {
        for (other_digits in digit_sum(digit, digit)) {
            if (n - length(other_digits) - 1 < 0) {
                next()
            }
            digits <- table(c(digit, other_digits))
            for (m in names(digits)) {
                partial_digits <- digits
                partial_digits[m] <- partial_digits[m] - 1
                multinomial <- reverted_factorial(length(other_digits))
                for (p in partial_digits) {
                    multinomial <- multinomial %/% factorial(p)
                }
                total <- total + all_digits * m * multinomial
            }
        }
        total <- total %% modulo
    }
    return(total)
}
