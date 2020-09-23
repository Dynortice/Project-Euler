from euler.big_int import BigInt


def compute(n: int) -> int:
    max_sum = 0
    for a in range(1, n):
        number = BigInt('1')
        for b in range(1, n):
            number *= BigInt(str(a))
            max_sum = max(max_sum, sum(map(int, number.str)))
    return max_sum
