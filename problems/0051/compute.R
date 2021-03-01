source("euler/R/primes.R")

compute <- function(n) {
    sieve <- prime_sieve(10 ^ (n - 1))
    for (i in seq_along(sieve)) {
        if (!sieve[i] || i < 10) next
        digits <- intToUtf8(utf8ToInt(as.character(i)), multiple = TRUE)
        most_common <- table(digits[-length(digits)])
        common_digit <- as.integer(names(which.max(most_common)))
        if (max(most_common) == 1 || common_digit > 9 - n) next
        family <- NULL
        for (j in common_digit:9) {
            member <- digits
            member[member == common_digit] <- j
            family <- c(family, as.integer(paste0(member, collapse = "")))
        }
        if (sum(sieve[family]) >= n) return(i)
    }
}
