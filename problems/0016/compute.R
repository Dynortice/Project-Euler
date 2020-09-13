source("../../euler/R/big_int.R")

compute <- function(n, p) {
    return(sum(BigInt$new(as.character(n))$pow(p)$digits))
}
