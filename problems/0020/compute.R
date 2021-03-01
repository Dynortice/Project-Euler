source("euler/R/big_int.R")
source("euler/R/numbers.R")

compute <- function(n) digits_sum(prod.bigint(lapply(seq_len(n), as.bigint)))
