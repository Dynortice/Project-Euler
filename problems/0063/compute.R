source("euler/R/big_int.R")

compute <- function() {
    result <- 0
    i <- 1
    while (TRUE) {
        j <- 1
        number <- as.bigint(i)
        n <- as.bigint(i)
        if (length(number) != j) {
            break
        } else {
            result <- result + 1
        }
        while (TRUE) {
            j <- j + 1
            number %*=% n
            if (length(number) == j) {
                result <- result + 1
            } else {
                break
            }
        }
        i <- i + 1
    }
    return(result)
}
