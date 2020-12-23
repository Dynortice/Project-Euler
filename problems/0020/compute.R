source("euler/R/big_int.R")

compute <- function(n) {
    return(sum(as.integer(strsplit(prod.bigint(lapply(seq_len(n), as.bigint))$str, NULL)[[1]])))
}
