from math import factorial
from itertools import combinations_with_replacement


def compute() -> int:
    result = 0
    factorials = {i: factorial(i) for i in range(10)}
    for i in range(2, 8):
        for number in combinations_with_replacement(factorials.keys(), i):
            candidate = sum(factorials[i] for i in number)
            if sorted(map(int, str(candidate))) == sorted(number):
                result += candidate
    return result
