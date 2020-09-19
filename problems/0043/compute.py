from itertools import permutations


def compute(n: int) -> int:
    digits = set(map(str, range(n + 1)))
    primes = [17, 13, 11, 7, 5, 3, 2]
    result = 0

    def get_permutation_numbers(used: tuple, nth_prime):
        sub_result = 0
        for i in digits.difference(used):
            if int(i + ''.join(used[:2])) % primes[nth_prime] == 0:
                if nth_prime < 6:
                    sub_result += get_permutation_numbers(tuple(i) + used, nth_prime + 1)
                else:
                    used_digits = tuple(i) + used
                    sub_result += int(''.join(tuple(digits.difference(used_digits)) + used_digits))
        return sub_result

    for permutation in permutations(digits, 3):
        if int(''.join(permutation)) % primes[9 - n] == 0:
            result += get_permutation_numbers(permutation, 9 - n + 1)

    return result
