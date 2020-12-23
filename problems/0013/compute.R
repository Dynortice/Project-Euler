source("euler/R/big_int.R")

compute <- function(n, numbers) {
    return(substr(sum.bigint(lapply(strsplit(numbers, "\n")[[1]], as.bigint))$str, 1, n))
}
