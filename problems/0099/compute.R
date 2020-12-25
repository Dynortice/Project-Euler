compute <- function(path) {
    base_exp <- lapply(strsplit(readLines(path, warn = FALSE), ","), as.integer)
    max_exponent <- 0
    result <- 0
    for (i in seq_along(base_exp)) {
        exponent <- log10(base_exp[[i]][1]) * base_exp[[i]][2]
        if (exponent > max_exponent) {
            max_exponent <- exponent
            result <- i
        }
    }
    return(result)
}
