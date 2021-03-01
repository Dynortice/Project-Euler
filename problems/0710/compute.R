compute <- function(m) {
    n <- c(4, 2, 1); pow <- 4; i <- 4; result <- 1
    while (result != 0) {
        n <- c((2 * n[1] - n[2] + n[3]) %% m, n[1:2])
        pow <- (pow * 2) %% m
        result <- pow - n[2]
        i <- i + 2
    }
    return(i)
}
