source("/euler/R/big_int.R")

compute <- function() {
    return(pow(as.bigint(2), 7830457, "10000000000") * 28433 %% "10000000000" + 1)
}
