from math import factorial
from itertools import combinations_with_replacement
from euler.numbers import get_digits


def compute() -> int:
    result = 0
    factorials = {i: factorial(i) for i in range(10)}
    for i in range(2, 8):
        for number in combinations_with_replacement(factorials.keys(), i):
            candidate = sum(factorials[i] for i in number)
            if sorted(get_digits(candidate)) == sorted(number):
                result += candidate
    return result
