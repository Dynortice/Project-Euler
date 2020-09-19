compute <- function(d) {
    digits_number <- function(k) {
        return((10 ^ k * (9 * k - 1) + 1) %/% 9)
    }
    get_digit <- function(n) {
        k <- 0
        while (digits_number(k + 1) < n) {
            k <- k + 1
        }
        k <- k + 1
        rem <- n - digits_number(k - 1)
        num <- 10 ^ (k - 1) + rem %/% k - 1
        if (rem %% k == 0) {
            return(tail(as.integer(strsplit(as.character(num), NULL)[[1]]), 1))
        } else {
            return(as.integer(strsplit(as.character(num + 1), NULL)[[1]])[rem %% k])
        }
    }
    result <- 1
    for (i in 0:d) {
        result <- result * get_digit(10 ^ i)
    }
    return(result)
}