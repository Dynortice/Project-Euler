compute <- function(n) {
    perimeters <- NA
    for (a in 3:(n %/% 3)) {
        for (b in a:(n %/% 2)) {
            k <- a * a + b * b
            if (k == as.integer(sqrt(k)) ^ 2) {
                p <- a + b + sqrt(k)
                if (is.na(perimeters[p])) {
                    perimeters[p] <- 1
                } else {
                    perimeters[p] <- perimeters[p] + 1
                }
            }
        }
    }
    return(which.max(perimeters))
}
