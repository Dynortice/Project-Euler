source("euler/R/big_int.R")
source("euler/R/numbers.R")

compute <- function(n) {
    result <- 0
    for (i in seq_len(n)) {
        number <- as.bigint(i)
        number %+=% as.bigint(intToUtf8(rev(utf8ToInt(number$str))))
        j <- 1
        while ((j <= 50) & (!is.palindrome(number))) {
            number %+=% as.bigint(intToUtf8(rev(utf8ToInt(number$str))))
            j <- j + 1
        }
        if (j > 50) {
            result <- result + 1
        }
    }
    return(result)
}
