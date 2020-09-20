compute <- function(n) {
    result <- 0
    for (i in 1:n) {
        n <- i
        for (j in 2:i) {
            n <- (n * i) %% 10 ^ 10
        }
        result <- result + n
    }
    return(result %% 10 ^ 10)
}