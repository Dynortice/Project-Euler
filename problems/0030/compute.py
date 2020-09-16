from itertools import combinations_with_replacement


def compute(n: int) -> int:
    max_len = 2
    result = 0
    while len(str(max_len * 9 ** n)) > max_len:
        max_len += 1
        for powers, digits in zip(combinations_with_replacement([i ** n for i in range(10)], max_len), combinations_with_replacement(range(10), max_len)):
            if sorted(map(int, str(sum(powers)))) == sorted(digits):
                result += sum(powers)
    return result
