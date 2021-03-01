from math import prod, factorial
from collections import Counter
from itertools import combinations_with_replacement


def compute(n: int) -> int:
    squares = [i * i for i in range(10)]
    result = 0
    for i in combinations_with_replacement(range(10), n):
        combination = ''.join(map(str, i))
        while True:
            combination = sum(squares[j] for j in map(int, combination))
            if combination == 89:
                result += factorial(n) // prod(map(factorial, Counter(i).values()))
                break
            elif combination < 2:
                break
            else:
                combination = str(combination)
    return result
