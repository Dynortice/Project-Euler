source("euler/R/big_int.R")

compute <- function(n, p) {
    return(sum(as.integer(strsplit((as.bigint(n) ^ p)$str, NULL)[[1]])))
}
