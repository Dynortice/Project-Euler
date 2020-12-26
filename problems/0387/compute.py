from euler.numbers import digits_sum
from euler.primes import is_prime


def compute(n):
    harshad_numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    result = 0
    for _ in range(1, n - 1):
        new_harshad_numbers = list()
        for i in range(10):
            for harshad in harshad_numbers:
                if (harshad * 10 + i) % (digits_sum(harshad) + i) == 0:
                    new_harshad = harshad * 10 + i
                    new_harshad_numbers.append(new_harshad)
                    if is_prime(new_harshad // digits_sum(new_harshad)):
                        for j in [1, 3, 7, 9]:
                            if is_prime(new_harshad * 10 + j):
                                result += new_harshad * 10 + j
        harshad_numbers = new_harshad_numbers
    return result
