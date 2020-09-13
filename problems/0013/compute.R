source("euler/R/big_int.R")

compute <- function(n, numbers) {
    numbers <- strsplit(numbers, "\n")[[1]]
    result <- BigInt$new("0")
    for (number in numbers) {
        result$iadd(BigInt$new(number))
    }
    return(substr(result$str, 1, n))
}
