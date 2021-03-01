source("euler/R/numbers.R")

compute <- function(n) {
    result <- 0
    for (i in as.numeric(2:n)) if (is.s_number(i, i * i)) result <- result + i * i
    return(result)
}
