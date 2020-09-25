source("euler/R/big_int.R")

compute <- function(n) {
    max_sum <- 0
    for (a in (n - 5):(n - 1)) {
        number <- BigInt$new(as.character(a))
        for (b in 1:(n - 1)) {
            number$imul(BigInt$new(as.character(a)))
            max_sum <- max(max_sum, sum(as.integer(strsplit(number$str, NULL)[[1]])))
        }
    }
    return(max_sum)
}