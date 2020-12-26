source("euler/R/numbers.R")
source("euler/R/primes.R")

compute <- function(n) {
    harshad_numbers <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
    result <- 0
    for (i in seq_len(n - 2)) {
        new_harshad_numbers <- NULL
        for (j in 0:9) {
            for (harshad in harshad_numbers) {
                if ((harshad * 10 + j) %% (digits_sum(harshad) + j) == 0) {
                    new_harshad <- harshad * 10 + j
                    new_harshad_numbers <- c(new_harshad_numbers, new_harshad)
                    if (is.prime(new_harshad %/% digits_sum(new_harshad))) {
                        for (k in c(1, 3, 7, 9)) {
                            if (is.prime(new_harshad * 10 + k)) {
                                result <- result + new_harshad * 10 + k
                            }
                        }
                    }
                }
            }
        }
        harshad_numbers <- new_harshad_numbers
    }
    return(result)
}