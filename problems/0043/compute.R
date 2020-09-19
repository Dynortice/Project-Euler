library(arrangements)

compute <- function(n) {
    digits <- 0:n
    primes <- c(17, 13, 11, 7, 5, 3, 2)
    result <- 0

    get_permutation_numbers <- function(used, nth_prime) {
        sub_result <- 0
        for (i in digits[!digits %in% used]) {
            if (as.integer(paste0(c(i, used[1:2]), collapse = "")) %% primes[nth_prime] == 0) {
                if (nth_prime < 7) {
                    sub_result <- sub_result + get_permutation_numbers(c(i, used), nth_prime + 1)
                } else {
                    used_digits <- c(i, used)
                    sub_result <- sub_result + as.numeric(paste0(c(digits[!digits %in% used_digits], used_digits), collapse = ""))
                }
            }
        }
        return(sub_result)
    }

    perms <- permutations(digits, 3)
    for (i in seq_len(nrow(perms))) {
        if (as.integer(paste0(perms[i,], collapse = "")) %% primes[9 - n + 1] == 0) {
            result <- result + get_permutation_numbers(perms[i,], 9 - n + 2)
        }
    }

    return(result)
}