compute <- function() {
    digits <- as.character(1:9)
    for (i in 9487:9234) {
        candidate <- i * 100002
        candidate_digits <- sort(unique(strsplit(as.character(candidate), NULL)[[1]]))
        if (length(candidate_digits) == 9) {
            if (sum(candidate_digits == digits) == 9) {
                return(candidate)
            }
        }
    }
}