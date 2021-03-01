from itertools import permutations
from euler.primes import prime_numbers


def compute(n: int) -> int:
    def get_permutation_numbers(used: tuple, prime_index):
        sub_result = 0
        for i in digits.difference(used):
            if int(i + ''.join(used[:2])) % primes[prime_index] == 0:
                if prime_index < 6:
                    sub_result += get_permutation_numbers(tuple(i) + used, prime_index + 1)
                else:
                    used_digits = tuple(i) + used
                    sub_result += int(''.join(tuple(digits.difference(used_digits)) + used_digits))
        return sub_result

    digits = set(map(str, range(n + 1)))
    primes = list(reversed(list(prime_numbers(17))))
    result = 0
    for permutation in permutations(digits, 3):
        if int(''.join(permutation)) % primes[9 - n] == 0:
            result += get_permutation_numbers(permutation, 10 - n)
    return result
