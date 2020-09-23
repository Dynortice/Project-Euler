source("euler/R/big_int.R")

compute <- function(n) {
    max_sum <- 0
    for (a in 1:(n - 1)) {
        a_big <- BigInt$new(as.character(a))
        print(a_big$str)
        number <- a_big$copy()
        for (b in 1:(n - 1)) {
            number$imul(a_big)
            max_sum <- max(max_sum, sum(as.integer(strsplit(number$str, NULL)[[1]])))
        }
    }
    return(max_sum)
}


microbenchmark(compute(100), times = 1)