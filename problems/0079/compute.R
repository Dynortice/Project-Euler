compute <- function(path) {
    keylog <- unique(readLines(path, warn = FALSE))
    password <- ""
    while (length(keylog) != 1) {
        candidates <- unique(sapply(keylog, function (x) substr(x, 1, 1)))
        for (candidate in candidates) {
            for (key in keylog) {
                if (grepl(candidate, substr(key, 2, nchar(key)))) {
                    candidates <- candidates[candidates != candidate]
                    break
                }
            }
        }
        password <- paste0(password, candidates)
        new_keylog <- NULL
        for (key in keylog) {
            if (candidates == substr(key, 1, 1)) {
                if (nchar(key) == 3) new_keylog <- c(new_keylog, substr(key, 2, 3))
                keylog <- keylog[keylog != key]
            }
        }
        keylog <- unique(c(keylog, new_keylog))
    }
    return(paste0(password, keylog))
}
