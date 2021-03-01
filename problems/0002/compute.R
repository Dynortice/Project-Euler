source("euler/R/calculus.R")

compute <- function(n) as.integer(get_fibonacci(fibonacci_index(n) + 2) / 2)