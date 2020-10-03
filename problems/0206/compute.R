source("euler/R/big_int.R")

compute <- function() {
    is.match <- function(n) {
        for (i in 0:8) {
            if (substr(n$str, i * 2 + 1, i * 2 + 1) != as.character(i + 1)) {
                return(FALSE)
            }
        }
        return(TRUE)
    }

    number <- BigInt$new("138902663")
    j <- 3
    while (!is.match(number$mul(number))) {
        if (j == 3) {
            number$isub(6)
            j <- 7
        } else {
            number$isub(4)
            j <- 3
        }
    }
    return(number$mul(10))
}
