options(scipen = 20)

compute <- function(n) {
    is.bouncy <- function(x) {
        digits <- strsplit(as.character(x), "")[[1]]
        sorted_digits <- sort(digits)
        if (all(digits == sorted_digits) | all(digits == rev(sorted_digits))) {
            return(FALSE)
        } else {
            return(TRUE)
        }
    }
    bouncy <- 0
    i <- 1
    while (TRUE) {
        bouncy <- bouncy + is.bouncy(i)
        if (bouncy / i >= n) {
            return(i)
        }
        i <- i + 1
    }
}
