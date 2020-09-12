source("euler/R/calculus.R")

compute <- function(a, b, n) {
  n <- n - 1
  return(sum(sum_arithmetic_series(a, a, n %/% a),
             sum_arithmetic_series(b, b, n %/% b),
             - sum_arithmetic_series(a * b, a * b, n %/% (a * b))))
}