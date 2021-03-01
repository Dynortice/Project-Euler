source("euler/R/numbers.R")

compute <- function() {
    numerators_product <- 1
    denominators_product <- 1
    for (i in seq_len(9)) {
        for (j in seq_len(i)) {
            for (k in seq_len(j - 1)) {
                if ((k * 10 + i) * j == (i * 10 + j) * k) {
                    numerators_product <- numerators_product * k
                    denominators_product <- denominators_product * j
                }
            }
        }
    }
    return(denominators_product / gcd(numerators_product, denominators_product))
}