from euler.numbers import add


def compute(n: int, numbers: str) -> str:
    numbers = numbers.split('\n')
    result = '0'
    for number in numbers:
        result = add(result, number)
    return result[:n]
