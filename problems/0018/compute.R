compute <- function (triangle) {
    triangle <- lapply(strsplit(strsplit(triangle, "\n")[[1]], " "), as.integer)
    while (length(triangle) > 1) {
        len <- length(triangle)
        for (i in seq_len(len - 1)) {
            triangle[[len - 1]][i] <- triangle[[len - 1]][i] + max(triangle[[len]][i:(i + 1)])
        }
        triangle <- triangle[-len]
    }
    return(triangle[[1]])
}
