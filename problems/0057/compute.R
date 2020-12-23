source("euler/R/big_int.R")

compute <- function(d, n) {
    numerator <- as.bigint(1)
    denominator <- as.bigint(1)
    a <- d
    b <- d - 1
    result <- 0
    for (i in seq_len(n)) {
        denominator_next <- numerator + b * denominator
        numerator %+=% (a * denominator)
        denominator <- denominator_next
        if (length(numerator) != length(denominator)) {
            result <- result + 1
        }
    }
    return(result)
}
