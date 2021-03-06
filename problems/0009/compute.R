compute <- function(n) {
    for (c in (n %/% 3 + 1):(n %/% 2)) {
        s <- c * c - n * n + 2 * c * n
        if (s > 0) {
            t <- as.integer(sqrt(s))
            if (t * t == s) {
                b <- (n - c + t) / 2
                a <- n - c - b
                return(a * b * c)
            }
        }
    }
}
