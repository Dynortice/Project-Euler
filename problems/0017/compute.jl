include("euler/euler.jl")
using .Math: fast_max


function compute(number::Int)::Int
    numbers_below_10 = length.(["one", "two", "three", "four", "five", "six", "seven", "eight",
                                "nine"])
    numbers_below_20 = length.(["ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen",
                                "sixteen", "seventeen", "eighteen", "nineteen"])
    tenth = length.(["twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"])
    sum_numbers_below_10, sum_numbers_below_20 = sum(numbers_below_10), sum(numbers_below_20)
    sum_tenths = sum(tenth)
    sum_hundreds = length("hundred")
    sum_and = length("and")
    sum_thousands = length("thousand")
    thousands, hundreds = number ÷ 1000, number % 1000 ÷ 100
    tenths, digits = number % 100 ÷ 10, number % 10
    sum_numbers_below_10 = 190thousands * sum_numbers_below_10 +
        (thousands > 0 ? 1000sum(numbers_below_10[1:thousands - 1]) +
            (100hundreds + 10tenths + digits + 1)numbers_below_10[thousands] : 0) +
        (hundreds > 0 ? 100sum(numbers_below_10[1:hundreds - 1]) + (10tenths + digits + 1) *
            numbers_below_10[hundreds] : 0) +
        9hundreds * sum_numbers_below_10 +
        (tenths ≠ 1 ? fast_max((tenths - 1)sum_numbers_below_10, 0) +
            sum(numbers_below_10[1:digits]) : sum_numbers_below_10)
    sum_numbers_below_20 = 10thousands * sum_numbers_below_20 + hundreds * sum_numbers_below_20 +
        (tenths > 1 ? sum_numbers_below_20 : 0) +
        (tenths == 1 ? sum(numbers_below_20[1:digits]) : 0)
    sum_tenths = 100thousands * sum_tenths + 10hundreds * sum_tenths +
        (tenths > 2 ? 10sum(tenth[1:tenths - 2]) : 0) +
        (tenths == 2 || tenths == 9 ? (digits + 1)tenth[tenths - 1] : 0)
    sum_hundreds = 900thousands * sum_hundreds + fast_max(100 * (hundreds - 1)sum_hundreds, 0) +
        (hundreds > 0 ? (10tenths + digits + 1)sum_hundreds : 0)
    sum_and = 891thousands * sum_and + fast_max(99 * (hundreds - 1)sum_and, 0) +
        (hundreds > 0 ? (10tenths + digits)sum_and : 0)
    sum_thousands = fast_max(1000 * (thousands - 1), 0) +
        (thousands > 0 ? (100hundreds + 10tenths + digits + 1)sum_thousands : 0)
    return sum_numbers_below_10 + sum_numbers_below_20 + sum_tenths + sum_hundreds + sum_and +
        sum_thousands
end
