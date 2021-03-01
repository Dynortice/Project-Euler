compute <- function() {
    digits <- as.character(1:9)
    for (i in 9487:9234) {
        candidate <- i * 100002
        candidate_digits <- sort(unique(intToUtf8(utf8ToInt(as.character(candidate)), multiple = TRUE)))
        if (length(candidate_digits) == 9 && all(candidate_digits == digits)) return(candidate)
    }
}