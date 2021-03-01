source("euler/R/big_int.R")

compute <- function() {
    result <- 0
    for (i in seq_len(9)) {
        j <- 1; n <- as.bigint(i)
        while (length(n) == j) {
            result <- result + 1
            j <- j + 1
            n %*=% i
        }
    }
    return(result)
}
