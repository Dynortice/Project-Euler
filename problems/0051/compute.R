source("euler/R/primes.R")

compute <- function(n) {
    get_family <- function(candidate, digit) {
        result <- NULL
        for (i in as.integer(digit):9) {
            j <- candidate
            j[j == digit] <- i
            result <- c(result, paste0(j, collapse = ""))
        }
        return(as.integer(result))
    }
    sieve <- get_primality(10 ^ (n - 1))
    for (prime in which(sieve)) {
        if (prime < 10) {
            next
        }
        str_number <- as.character(prime)
        digits <- strsplit(str_number, "")[[1]]
        most_common <- table(digits[1:(nchar(str_number) - 1)])
        if ((max(most_common) == 1) | (as.integer(names(which.max(most_common))) > 9 - n)) {
            next
        }
        if (sum(sieve[get_family(digits, as.integer(names(which.max(most_common))))]) == n) {
            return(prime)
        }
    }
}
