source("euler/R/calculus.R")

compute <- function(n) {
    result <- 0
    max_chain <- 0
    len_collatz_chain <- len_collatz_chain()
    for (i in 1:(n - 1)) {
        if (len_collatz_chain(i) > max_chain) {
            max_chain <- len_collatz_chain(i)
            result <- i
        }
    }
    return(result)
}
