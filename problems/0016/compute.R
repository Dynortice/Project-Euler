source("euler/R/big_int.R")

compute <- function(n, p) {
    return(sum(as.integer(strsplit(BigInt$new(as.character(n))$pow(p)$str, NULL)[[1]])))
}
