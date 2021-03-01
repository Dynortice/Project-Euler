source("euler/R/calculus.R")

compute <- function(n) {
    result <- 1
    for (i in 0:n) {
        j <- 10 ^ i; k <- 0
        while (champernowne_digits(k + 1) < j) {
            k <- k + 1
        }
        k <- k + 1
        remainder <- j - champernowne_digits(k - 1)
        number <- 10 ^ (k - 1) + remainder %/% k - 1
        if (remainder %% k == 0) {
            result <- result * as.integer(intToUtf8(tail(utf8ToInt(as.character(number)), 1)))
        } else {
            result <- result * as.integer(intToUtf8(utf8ToInt(as.character(number + 1))[remainder %% k]))
        }
    }
    return(result)
}