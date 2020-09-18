from math import gcd


def compute():
    numerators_product = 1
    denominators_product = 1
    for i in range(1, 10):
        for j in range(1, i):
            for k in range(1, j):
                if (k * 10 + i) * j == (i * 10 + j) * k:
                    numerators_product *= k
                    denominators_product *= j
    return denominators_product // gcd(numerators_product, denominators_product)
