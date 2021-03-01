source("euler/R/big_int.R")
source("euler/R/numbers.R")

compute <- function(n, p) digits_sum(as.bigint(n) ^ p)
