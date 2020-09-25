from math import prod, factorial
from collections import Counter
from itertools import combinations_with_replacement


def compute(n: int) -> int:
    def sum_squares_digits(x: str):
        return sum(map(lambda y: y ** 2, map(int, x)))

    result = 0
    for i in combinations_with_replacement(map(str, range(10)), n):
        combination = ''.join(i)
        while True:
            combination = sum_squares_digits(combination)
            if combination == 89:
                result += factorial(n) // prod(map(factorial, Counter(i).values()))
                break
            elif combination < 2:
                break
            else:
                combination = str(combination)
    return result
