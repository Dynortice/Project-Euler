source("euler/R/big_int.R")

compute <- function(n) {
    is.palindrome <- function(x) {
        return(x$str == intToUtf8(rev(utf8ToInt(x$str))))
    }

    result <- 0
    for (i in seq_len(n)) {
        number <- BigInt$new(as.character(i))
        number$iadd(BigInt$new(intToUtf8(rev(utf8ToInt(number$str)))))
        j <- 1
        while ((j <= 50) & (!is.palindrome(number))) {
            number$iadd(BigInt$new(intToUtf8(rev(utf8ToInt(number$str)))))
            j <- j + 1
        }
        if (j > 50) {
            result <- result + 1
        }
    }
    return(result)
}