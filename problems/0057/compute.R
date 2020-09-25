source("euler/R/big_int.R")

compute <- function(d, n) {
    numerator <- BigInt$new("1")
    denominator <- BigInt$new("1")
    a <- BigInt$new(as.character(d))
    b <- BigInt$new(as.character(d - 1))
    result <- 0
    for (i in seq_len(n)) {
        denominator_next <- numerator$add(denominator$mul(b))
        numerator$iadd(denominator$mul(a))
        denominator <- denominator_next
        if (nchar(numerator$str) != nchar(denominator$str)) {
            result <- result + 1
        }
    }
    return(result)
}
