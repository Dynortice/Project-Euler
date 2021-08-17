from math import modf


def compute(t: int, n: int) -> str:
    def next_b(b: float) -> float:
        b, a = modf(b)
        return a * (1 + b)

    result = f'{t}.'
    i = 1
    while len(result) < n + 2:
        x = float(result)
        for _ in range(i):
            x = next_b(x)
        result += str(int(x))
        i += 1
    return result
