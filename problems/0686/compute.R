compute <- function(digits, n) {
    digits_len <- ceiling(log10(digits))
    number <- 2; repetitions <- 0; result <- 1
    while (TRUE) {
        result <- result + 1; number <- number * 2
        if (log10(number) > digits_len) number <- number / 10
        if (as.integer(number) == digits) {
            repetitions <- repetitions + 1
            if (repetitions == n) break
        }
    }
    return(result)
}
