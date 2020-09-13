compute <- function(n, digits) {
    l <- length(digits)
    result <- ""
    remain <- n - 1
    for (i in seq_len(l)) {
        order <- factorial(l - i)
        j <- remain %/% order + 1
        result <- paste0(result, digits[j])
        remain <- remain %% order
        digits <- digits[-j]
    }
    return(result)
}
