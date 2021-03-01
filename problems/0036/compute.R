compute <- function(n) {
    result <- 0
    for (i in seq_len(log10(n))) {
        for (j in (10 ^ ceiling(i / 2 - 1)):(10 ^ ceiling(i / 2) - 1)) {
            palindrome <- as.integer(paste0(j, paste0(rev(intToUtf8(utf8ToInt(as.character(j)), multiple = TRUE)[0:(i %/% 2)]), collapse = ""), collapse = ""))
            binary <- trimws(paste0(as.integer(rev(intToBits(palindrome))), collapse = ""), "left", "0")
            if (binary == intToUtf8(rev(utf8ToInt(binary)))) result <- result + palindrome
        }
    }
    return(result)
}
