from itertools import combinations_with_replacement


def compute(n: int) -> int:
    max_len = 2
    result = 0
    powers = {i: i ** n for i in range(10)}
    while len(str(max_len * 9 ** n)) >= max_len:
        for digits in combinations_with_replacement(powers.keys(), max_len):
            candidate = sum(powers[i] for i in digits)
            if sorted(map(int, str(candidate))) == sorted(digits):
                result += candidate
        max_len += 1
    return result
