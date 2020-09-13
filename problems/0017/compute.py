def compute(number):
    numbers_below_10 = [
        len('one'),
        len('two'),
        len('three'),
        len('four'),
        len('five'),
        len('six'),
        len('seven'),
        len('eight'),
        len('nine')
    ]
    numbers_below_20 = [
        len('ten'),
        len('eleven'),
        len('twelve'),
        len('thirteen'),
        len('fourteen'),
        len('fifteen'),
        len('sixteen'),
        len('seventeen'),
        len('eighteen'),
        len('nineteen')
    ]
    tenth = [
        len('twenty'),
        len('thirty'),
        len('forty'),
        len('fifty'),
        len('sixty'),
        len('seventy'),
        len('eighty'),
        len('ninety')
    ]
    sum_numbers_below_10 = sum(numbers_below_10)
    sum_numbers_below_20 = sum(numbers_below_20)
    sum_tenth = sum(tenth)
    sum_hundreds = len('hundred')
    sum_and = len('and')
    sum_thousands = len('thousand')
    thousands = number // 1000
    hundreds = number % 1000 // 100
    tenths = number % 100 // 10
    digits = number % 10
    sum_numbers_below_10 = 190 * thousands * sum_numbers_below_10 + (1000 * sum(
        numbers_below_10[0:thousands - 1]) + (100 * hundreds + 10 * tenths + digits + 1) * numbers_below_10[thousands - 1] if thousands > 0 else 0) + (100 * sum(
        numbers_below_10[0:hundreds - 1]) + (10 * tenths + digits + 1) * numbers_below_10[hundreds - 1] if hundreds > 0 else 0) + 9 * hundreds * sum_numbers_below_10 + (max(
        (tenths - 1) * sum_numbers_below_10, 0) + sum(
        numbers_below_10[0:digits]) if tenths != 1 else sum_numbers_below_10)
    sum_numbers_below_20 = 10 * thousands * sum_numbers_below_20 + hundreds * sum_numbers_below_20 + (sum_numbers_below_20 if tenths > 1 else 0) + (sum(
        numbers_below_20[0:digits]) if tenths == 1 else 0)
    sum_tenth = 100 * thousands * sum_tenth + 10 * hundreds * sum_tenth + (10 * sum(
        tenth[0:tenths - 2]) if tenths > 2 else 0) + ((digits + 1) * tenth[tenths - 2] if tenths == 2 or tenths == 9 else 0)
    sum_hundreds = 900 * thousands * sum_hundreds + max(
        100 * (hundreds - 1) * sum_hundreds, 0) + ((10 * tenths + digits + 1) * sum_hundreds if hundreds > 0 else 0)
    sum_and = 891 * thousands * sum_and + max(
        99 * (hundreds - 1) * sum_and, 0) + ((10 * tenths + digits) * sum_and if hundreds > 0 else 0)
    sum_thousands = max(1000 * (thousands - 1), 0) + ((100 * hundreds + 10 * tenths + digits + 1) * sum_thousands if thousands > 0 else 0)
    return sum_numbers_below_10 + sum_numbers_below_20 + sum_tenth + sum_hundreds + sum_and + sum_thousands
