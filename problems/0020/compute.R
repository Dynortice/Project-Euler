source("../../euler/R/big_int.R")

compute <- function(n) {
    result <- BigInt$new("1")
    for (i in seq_len(n)) {
        result$imul(BigInt$new(as.character(i)))
    }
    return(sum(as.integer(strsplit(result$str, NULL)[[1]])))
}
