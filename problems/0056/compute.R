source("euler/R/big_int.R")
source("euler/R/math.R")
source("euler/R/numbers.R")

compute <- function(n) {
    result <- 0
    for (a in (n - 5):(n - 1)) {
        number <- as.bigint(a)
        for (b in seq_len(n - 1)) {
            number %*=% a
            result <- fast_max(result, digits_sum(number))
        }
    }
    return(max_sum)
}