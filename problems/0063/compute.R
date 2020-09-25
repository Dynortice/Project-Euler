source("euler/R/big_int.R")

compute <- function() {
    result <- 0
    i <- 1
    while (TRUE) {
        j <- 1
        number <- BigInt$new(as.character(i))
        n <- BigInt$new(as.character(i))
        if (nchar(number$str) != j) {
            break
        } else {
            result <- result + 1
        }
        while (TRUE) {
            j <- j + 1
            number$imul(n)
            if (nchar(number$str) == j) {
                result <- result + 1
            } else {
                break
            }
        }
        i <- i + 1
    }
    return(result)
}
