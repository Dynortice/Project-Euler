source("../euler/R/calculus.R")

compute <- function(n) {
    result <- 0
    max_chain <- 0
    hashmap <- 1
    for (i in 1:(n - 1)) {
        hashmap[i] <- len_collatz_chain(i, hashmap)
        if (hashmap[i] > max_chain) {
            max_chain <- hashmap[i]
            result <- i
        }
    }
    return(result)
}
