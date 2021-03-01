compute <- function(n) {
    cubes <- list(); permutations <- list()
    for (i in seq_len(10 ^ n)) {
        permutation <- paste0(intToUtf8(sort(utf8ToInt(as.character(i ^ 3))), multiple = TRUE), collapse = "")
        if (is.null(cubes[[permutation]])) {
            cubes[[permutation]] <- i ^ 3
            permutations[[permutation]] <- 1
        } else {
            permutations[[permutation]] <- permutations[[permutation]] + 1
            if (permutations[[permutation]] == n) return(cubes[[permutation]])
        }
    }
}
