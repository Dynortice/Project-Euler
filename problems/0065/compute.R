source("euler/R/big_int.R")

compute <- function(n) {
    get_next_term <- function(previous, k) {
        if (k %% 3 == 1) {
            k <- k %/% 3
            return(previous[[1]] * k * 2 + previous[[2]])
        } else {
            return(sum.bigint(previous))
        }
    }
    terms <- c(BigInt$new(1), BigInt$new(1))
    for (i in 2:(n + 1)) {
        terms <- c(get_next_term(terms, i), terms[[1]])
    }
    return(sum(as.integer(strsplit(terms[[1]]$str, "")[[1]])))
}
