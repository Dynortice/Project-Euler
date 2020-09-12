compute <- function(n, digits) {
    digits <- as.integer(strsplit(gsub("\n", "", digits), NULL)[[1]])
    max_product <- 0
    for (i in 1:(length(digits) - n + 1)) {
        if (0 %in% digits[i:(i+n-1)]) {
            next
        }
        cur_product <- prod(digits[i:(i+n-1)])
        if (cur_product > max_product) {
            max_product <- cur_product
        }
    }
    return(max_product)
}
