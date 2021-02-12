compute <- function(n) {
    cubes <- list()
    permutations <- list()
    for (i in 1:(10 ^ n)) {
        permutation <- paste0(sort(strsplit(as.character(i ^ 3), "")[[1]]), collapse = "")
        if (is.null(cubes[[permutation]])) {
            cubes[[permutation]] <- i ^ 3
            permutations[[permutation]] <- 1
        } else {
            permutations[[permutation]] <- permutations[[permutation]] + 1
            if (permutations[[permutation]] == n) {
                return(cubes[[permutation]])
            }
        }
    }
}
