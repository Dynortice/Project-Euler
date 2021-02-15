compute <- function(a, b) {
    get_combinations <- function(p, n, s) {
        result <- 0
        for (k in 0:((p - n) %/% s)) {
            result <- result + (-1) ^ k * choose(n, k) * choose(p - 1 - s * k, n - 1)
        }
        return(result)
    }
    limit <- max(prod(a), prod(b))
    looses <- rep(0, limit)
    result <- 0
    for (i in b[1]:prod(b)) {
        looses[i] <- do.call(get_combinations, as.list(c(i, b))) + looses[i - 1]
    }
    for (i in a[1]:prod(a)) {
        result <- result + do.call(get_combinations, as.list(c(i, a))) * looses[i - 1]
    }
    return(round(result / a[2] ^ a[1] / b[2] ^ b[1], 7))
}
