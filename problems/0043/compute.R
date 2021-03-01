library(arrangements)
source("euler/R/primes.R")

compute <- function(n) {
    get_permutation_numbers <- function(used, prime_index) {
        sub_result <- 0
        for (i in digits[!digits %in% used]) {
            if (as.integer(paste0(c(i, used[1:2]), collapse = "")) %% primes[prime_index] == 0) {
                if (nth_prime < 7) {
                    sub_result <- sub_result + get_permutation_numbers(c(i, used), prime_index + 1)
                } else {
                    used_digits <- c(i, used)
                    sub_result <- sub_result + as.numeric(paste0(c(digits[!digits %in% used_digits], used_digits), collapse = ""))
                }
            }
        }
        return(sub_result)
    }
    digits <- 0:n
    primes <- rev(prime_numbers(17))
    result <- 0
    perms <- permutations(digits, 3)
    for (i in seq_len(nrow(perms))) {
        if (as.integer(paste0(perms[i,], collapse = "")) %% primes[10 - n] == 0) {
            result <- result + get_permutation_numbers(perms[i,], 11 - n)
        }
    }

    return(result)
}