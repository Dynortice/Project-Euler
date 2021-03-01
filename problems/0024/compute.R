compute <- function(n, digits) {
    k <- length(digits)
    result <- NULL
    remain <- n - 1
    for (i in seq_len(k)) {
        order <- factorial(k - i)
        j <- remain %/% order + 1
        result <- c(result, digits[j])
        remain <- remain %% order
        digits <- digits[-j]
    }
    return(paste0(result, collapse = ""))
}
