source("euler/R/big_int.R")
source("euler/R/numbers.R")

compute <- function(n) {
    current <- as.bigint(1); previous <- as.bigint(1)
    for (i in seq(2, n + 1)) {
        temp <- current
        if (i %% 3 == 1) current <- current * as.bigint(2 * i %/% 3)
        current <- current + previous; previous <- temp
    }
    return(digits_sum(current))
}
