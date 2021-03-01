library(bit64)
source("euler/R/big_int.R")

compute <- function() {
    min_value <- as.integer64(1504170715041707); max_value <- as.integer64(1504170715041707)
    modulo <- as.integer64(4503599627370517); result <- as.integer64(1504170715041707)
    candidate <- 0
    while (candidate != 1) {
        candidate <- (min_value + max_value) %% modulo
        if (candidate > max_value) {
            max_value <- candidate
        } else if (candidate < min_value) {
            min_value <- candidate
            result <- result + candidate
        }
    }
    return(result)
}
