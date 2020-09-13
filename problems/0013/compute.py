from euler.big_int import BigInt


def compute(n: int, numbers: str) -> str:
    numbers = numbers.split('\n')
    result = BigInt('0')
    for number in numbers:
        result += BigInt(number)
    return result[:n]
