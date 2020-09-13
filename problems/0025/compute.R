compute <- function(n) {
    return(ceiling((log(10) * (n - 1) + log(5) / 2) / log((1 + sqrt(5)) / 2)))
}
