source("../../euler/R/big_int.R")

compute <- function() {
    result <- BigInt$new("2")$pow(7830457, 10)$mul(BigInt$new("28433"))$add(BigInt$new("1"))$str
    return(substr(result, nchar(result) - 9, nchar(result)))
}
