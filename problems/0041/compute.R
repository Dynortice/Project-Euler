source("euler/R/primes.R")

compute <- function() {
    for (prime in rev(prime_numbers(7654321))) {
        digits <- sort(unique(intToUtf8(utf8ToInt(as.character(prime)), multiple = TRUE)))
        if (all(digits == seq_along(digits))) return(prime)
    }
}