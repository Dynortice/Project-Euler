source("../euler/R/numbers.R")

compute <- function(n, numbers) {
    numbers <- strsplit(numbers, "\n")[[1]]
    result <- "0"
    for (number in numbers) {
        result <- add(result, number)
    }
    return(digits_to_number(number_to_digits(result)[1:n]))
}
