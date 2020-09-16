from itertools import product


def compute(n: int) -> int:
    digits = set(map(str,  range(1, n + 1)))
    possible_numbers = {4: [(1, 1)], 5: [(1, 2)], 6: [(1, 2)], 7: [(1, 3), (2, 2)], 8: [(1, 3), (2, 2)],
                        9: [(1, 4), (2, 3)]}
    products = set()
    for i, j in possible_numbers[n]:
        for n in product(digits, repeat=i):
            if len(set(n)) == len(n):
                for m in product(digits.difference(n), repeat=j):
                    if len(set(m)) == len(m):
                        prod = int(''.join(n)) * int(''.join(m))
                        if sorted(n + m + tuple(str(prod))) == sorted(digits):
                            products.add(prod)
    return sum(products)
