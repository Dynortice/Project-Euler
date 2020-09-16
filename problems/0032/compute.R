compute <- function(k) {
    digits <- as.character(1:9)
    possible_numbers <- list(NULL, NULL, NULL, list(c(1, 1)), list(c(1, 2)), list(c(1, 2)), list(c(1, 3), c(2, 2)),
                             list(c(1, 3), c(2, 2)), list(c(1, 4), c(2, 3)))
    products <- NULL
    for (i in possible_numbers[[k]]) {
        multiplicands <- as.matrix(expand.grid(rep(list(digits), i[1]), stringsAsFactors = FALSE))
        for (n in seq_len(nrow(multiplicands))) {
            if (length(unique(multiplicands[n, ])) == i[1]) {
                multipliers <- as.matrix(expand.grid(rep(list(digits[!digits %in% multiplicands[n, ]]), i[2]), stringsAsFactors = FALSE))
                for (m in seq_len(nrow(multipliers))) {
                    if (length(unique(multipliers[m, ])) == i[2]) {
                        product <- as.integer(paste0(multiplicands[n, ], collapse = "")) * as.integer(paste0(multipliers[m, ], collapse = ""))
                        check_digits <- sort(c(multiplicands[n, ], multipliers[m, ], strsplit(as.character(product), NULL)[[1]]))
                        if (length(check_digits) == k) {
                            if (sum(check_digits == digits) == k)
                            products <- c(products, product)
                        }
                    }
                }
            }
        }
    }
    return(sum(unique(products)))
}
