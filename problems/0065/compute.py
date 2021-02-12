from euler.big_int import BigInt


def compute(n: int) -> int:
    def get_next_term(previous: [BigInt], k: int) -> BigInt:
        if k % 3 == 1:
            k //= 3
            return 2 * k * previous[0] + previous[1]
        else:
            return sum(previous)

    terms = [BigInt(1), BigInt(1)]
    for i in range(2, n + 2):
        terms = [get_next_term(terms, i), terms[0]]
    return sum(map(int, str(terms[0])))
