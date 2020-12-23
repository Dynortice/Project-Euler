source("euler/R/big_int.R")

compute <- function() {
    modulo <- as.bigint("4503599627370517")
    min_value <- as.bigint("1504170715041707")
    max_value <- as.bigint("1504170715041707")
    result <- as.bigint("1504170715041707")
    while (TRUE) {
        candidate <- (min_value + max_value) %% modulo
        if (candidate > max_value) {
            max_value <- candidate
        } else if (candidate < min_value) {
            min_value <- candidate
            result %+=% candidate
            if (candidate == 1) {
                break
            }
        }
    }
    return(result)
}
