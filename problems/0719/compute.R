library(bit64)

compute <- function(n) {
    is.s_number <- function(a, b) {
        if (a > b) {
            return(FALSE)
        } else if (a == b) {
            return(TRUE)
        }
        modulo <- 10
        while (modulo < b) {
            quotient <- b %/% modulo
            remainder <- b %% modulo
            if (remainder < a & is.s_number(a - remainder, quotient)) {
                return(TRUE)
            }
            modulo <- modulo * 10
        }
        return(FALSE)
    }
    result <- 0
    for (i in 2:n) {
        number <- as.integer64(i)
        if (is.s_number(number, number * number)) {
            result <- result + number * number
        }
    }
    return(result)
}
