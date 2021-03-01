compute <- function(n) {
    i <- 1
    while (TRUE) {
        for (j in seq(10 ^ i, 10 ^ (i + 1) %/% n - 1)) {
            j_digits <- sort(utf8ToInt(as.character(j)))
            is_permuted <- TRUE
            for (k in 2:n) {
                k_digits <- sort(utf8ToInt(as.character(j * k)))
                if (any(j_digits != k_digits)) {
                    is_permuted <- FALSE
                    break
                }
            }
            if (is_permuted) return(j)
        }
        i <- i + 1
    }
}
