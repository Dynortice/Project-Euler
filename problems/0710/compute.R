compute <- function(mod) {
    get_next_n <- function(args) {
        return(2 * args[1] - args[2] + args[3])
    }
    n <- c(4, 2, 1)
    pow <- 4
    i <- 4
    result <- 1
    while (result != 0) {
        n <- c(get_next_n(n) %% mod, n[1:2])
        pow <- (pow * 2) %% mod
        result <- pow - n[2]
        i <- i + 2
    }
    return(i)
}
