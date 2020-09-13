compute <- function(number) {
    numbers_below_10 <- c(
        0,
        nchar("one"),
        nchar("two"),
        nchar("three"),
        nchar("four"),
        nchar("five"),
        nchar("six"),
        nchar("seven"),
        nchar("eight"),
        nchar("nine")
    )
    numbers_below_20 <- c(
        nchar("ten"),
        nchar("eleven"),
        nchar("twelve"),
        nchar("thirteen"),
        nchar("fourteen"),
        nchar("fifteen"),
        nchar("sixteen"),
        nchar("seventeen"),
        nchar("eighteen"),
        nchar("nineteen")
    )
    tenth <- c(
        nchar("twenty"),
        nchar("thirty"),
        nchar("forty"),
        nchar("fifty"),
        nchar("sixty"),
        nchar("seventy"),
        nchar("eighty"),
        nchar("ninety")
    )
    sum_numbers_below_10 <- sum(numbers_below_10)
    sum_numbers_below_20 <- sum(numbers_below_20)
    sum_tenths <- sum(tenth)
    sum_hundreds <- nchar("hundred")
    sum_and <- nchar("and")
    sum_thousands <- nchar("thousand")
    thousands <- number %/% 1000
    hundreds <- number %% 1000 %/% 100
    tenths <- number %% 100 %/% 10
    digits <- number %% 10
    sum_numbers_below_10 <- 190 * thousands * sum_numbers_below_10 +
        1000 * sum(numbers_below_10[1:thousands]) +
        ifelse(thousands > 0,
               (100 * hundreds + 10 * tenths + digits + 1) *
                   numbers_below_10[thousands + 1], 0) +
        100 * sum(numbers_below_10[1:hundreds]) +
        ifelse(hundreds > 0,
               (10 * tenths + digits + 1) *
                   numbers_below_10[hundreds + 1], 0) +
        9 * hundreds * sum_numbers_below_10 +
        ifelse(tenths != 1, max((tenths - 1) * sum_numbers_below_10, 0) +
                   sum(numbers_below_10[1:(digits + 1)]), sum_numbers_below_10)
    sum_numbers_below_20 <- 10 * thousands * sum_numbers_below_20 +
        hundreds * sum_numbers_below_20 +
        ifelse(tenths > 1, sum_numbers_below_20, 0) +
        ifelse(tenths == 1, sum(numbers_below_20[1:digits]), 0)
    sum_tenths <- 100 * thousands * sum_tenths + 10 * hundreds * sum_tenths +
        ifelse(tenths > 2, 10 * sum(tenth[1:(tenths - 2)]), 0) +
        ifelse(tenths == 2 | tenths == 9, (digits + 1) * tenth[tenths - 1], 0)
    sum_hundreds <- 900 * thousands * sum_hundreds +
        max(100 * (hundreds - 1) * sum_hundreds, 0) +
        ifelse(hundreds > 0, (10 * tenths + digits + 1) * sum_hundreds, 0)
    sum_and <- 891 * thousands * sum_and +
        max(99 * (hundreds - 1) * sum_and, 0) +
        ifelse(hundreds > 0, (10 * tenths + digits) * sum_and, 0)
    sum_thousands <- max(1000 * (thousands - 1), 0) +
        ifelse(thousands > 0,
               (100 * hundreds + 10 * tenths + digits + 1) * sum_thousands, 0)
    return(sum_numbers_below_10 + sum_numbers_below_20 + sum_tenths +
        sum_hundreds + sum_and + sum_thousands)
}
