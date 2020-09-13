using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(number)
    numbers_below_10 = [
        length("one"),
        length("two"),
        length("three"),
        length("four"),
        length("five"),
        length("six"),
        length("seven"),
        length("eight"),
        length("nine")
    ]
    numbers_below_20 = [
        length("ten"),
        length("eleven"),
        length("twelve"),
        length("thirteen"),
        length("fourteen"),
        length("fifteen"),
        length("sixteen"),
        length("seventeen"),
        length("eighteen"),
        length("nineteen")
    ]
    tenth = [
        length("twenty"),
        length("thirty"),
        length("forty"),
        length("fifty"),
        length("sixty"),
        length("seventy"),
        length("eighty"),
        length("ninety")
    ]
    sum_numbers_below_10 = sum(numbers_below_10)
    sum_numbers_below_20 = sum(numbers_below_20)
    sum_tenths = sum(tenth)
    sum_hundreds = length("hundred")
    sum_and = length("and")
    sum_thousands = length("thousand")
    thousands = number ÷ 1000
    hundreds = number % 1000 ÷ 100
    tenths = number % 100 ÷ 10
    digits = number % 10
    sum_numbers_below_10 = 190 * thousands * sum_numbers_below_10 +
        (thousands > 0 ? 1000 * sum(numbers_below_10[1:thousands - 1]) +
        (100 * hundreds + 10 * tenths + digits + 1) *
        numbers_below_10[thousands] : 0) + (hundreds > 0 ? 100 *
        sum(numbers_below_10[1:hundreds - 1]) + (10 * tenths + digits + 1) *
        numbers_below_10[hundreds] : 0) + 9 * hundreds * sum_numbers_below_10 +
        (tenths ≠ 1 ? max((tenths - 1) * sum_numbers_below_10, 0) +
        sum(numbers_below_10[1:digits]) : sum_numbers_below_10)
    sum_numbers_below_20 = 10 * thousands * sum_numbers_below_20 +
        hundreds * sum_numbers_below_20 +
        (tenths > 1 ? sum_numbers_below_20 : 0) +
        (tenths == 1 ? sum(numbers_below_20[1:digits]) : 0)
    sum_tenths = 100 * thousands * sum_tenths + 10 * hundreds * sum_tenths +
        (tenths > 2 ? 10 * sum(tenth[1:tenths - 2]) : 0) +
        (tenths == 2 | tenths == 9 ? (digits + 1) * tenth[tenths - 1] : 0)
    sum_hundreds = 900 * thousands * sum_hundreds +
        max(100 * (hundreds - 1) * sum_hundreds, 0) +
        (hundreds > 0 ? (10 * tenths + digits + 1) * sum_hundreds : 0)
    sum_and = 891 * thousands * sum_and +
        max(99 * (hundreds - 1) * sum_and, 0) +
        (hundreds > 0 ? (10 * tenths + digits) * sum_and : 0)
    sum_thousands = max(1000 * (thousands - 1), 0) + (thousands > 0 ?
        (100 * hundreds + 10 * tenths + digits + 1) * sum_thousands : 0)
    return sum_numbers_below_10 + sum_numbers_below_20 + sum_tenths +
        sum_hundreds + sum_and + sum_thousands
end

compute(5)

compute(1000)

@benchmark compute(1000)