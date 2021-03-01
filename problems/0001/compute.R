source("euler/R/calculus.R")

compute <- function(a, b, n) {
  n <- n - 1
  ab <- a * b
  return(sum_arithmetic_series(a, a, n %/% a) + sum_arithmetic_series(b, b, n %/% b) - sum_arithmetic_series(ab, ab, n %/% ab))
}