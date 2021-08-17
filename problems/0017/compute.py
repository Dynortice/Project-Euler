from euler.math import fast_max


def compute(number: int) -> int:
    numbers_below_10 = list(map(len, ('one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine')))
    numbers_below_20 = list(map(len, ('ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen',
                                      'seventeen', 'eighteen', 'nineteen')))
    tenth = list(map(len, ('twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety')))
    sum_numbers_below_10 = sum(numbers_below_10)
    sum_numbers_below_20 = sum(numbers_below_20)
    sum_tenth = sum(tenth)
    sum_hundreds = len('hundred')
    sum_and = len('and')
    sum_thousands = len('thousand')
    thousands, hundreds, tenths, digits = number // 1_000, number % 1_000 // 100, number % 100 // 10, number % 10
    hundreds, tenths, digits = number % 1_000 // 100, number % 100 // 10, number % 10
    sum_numbers_below_10 = 190 * thousands * sum_numbers_below_10 \
        + (1_000 * sum(numbers_below_10[0:thousands - 1])
           + (100 * hundreds + 10 * tenths + digits + 1) * numbers_below_10[thousands - 1] if thousands > 0 else 0) \
        + (100 * sum(numbers_below_10[0:hundreds - 1])
           + (10 * tenths + digits + 1) * numbers_below_10[hundreds - 1] if hundreds > 0 else 0) \
        + 9 * hundreds * sum_numbers_below_10 \
        + (fast_max((tenths - 1) * sum_numbers_below_10, 0)
           + sum(numbers_below_10[0:digits]) if tenths != 1 else sum_numbers_below_10)
    sum_numbers_below_20 = 10 * thousands * sum_numbers_below_20 \
        + hundreds * sum_numbers_below_20 + (sum_numbers_below_20 if tenths > 1 else 0) \
        + (sum(numbers_below_20[0:digits]) if tenths == 1 else 0)
    sum_tenth = 100 * thousands * sum_tenth + 10 * hundreds * sum_tenth \
        + (10 * sum(tenth[0:tenths - 2]) if tenths > 2 else 0) \
        + ((digits + 1) * tenth[tenths - 2] if tenths == 2 or tenths == 9 else 0)
    sum_hundreds = 900 * thousands * sum_hundreds + fast_max(100 * (hundreds - 1) * sum_hundreds, 0) \
        + ((10 * tenths + digits + 1) * sum_hundreds if hundreds > 0 else 0)
    sum_and = 891 * thousands * sum_and + fast_max(99 * (hundreds - 1) * sum_and, 0)\
        + ((10 * tenths + digits) * sum_and if hundreds > 0 else 0)
    sum_thousands = fast_max(1_000 * (thousands - 1), 0) \
        + ((100 * hundreds + 10 * tenths + digits + 1) * sum_thousands if thousands > 0 else 0)
    return sum_numbers_below_10 + sum_numbers_below_20 + sum_tenth + sum_hundreds + sum_and + sum_thousands
