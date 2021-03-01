source("euler/R/big_int.R")

compute <- function(n, numbers) sum.bigint(lapply(strsplit(numbers, "\n")[[1]], as.bigint))[1:n]
