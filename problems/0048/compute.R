compute <- function(n) {
    result <- 0
    for (i in seq_len(n)) {
        n <- i
        for (j in 2:i) n <- (n * i) %% 10000000000
        result <- result + n
    }
    return(result %% 10000000000)
}