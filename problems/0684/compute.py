from euler.big_int import BigInt
from euler.calculus import fibonacci_generator


def compute(n: int, modulo: int) -> BigInt:
    def s_mod(k: BigInt) -> BigInt:
        a, b = k % 9 + 2, k // 9
        return (((a * (a - 1) + 10) * pow(BigInt(10), b, modulo) - 2 * (a + 9 * b + 4)) * inverted_modulo) % modulo

    inverted_modulo = pow(2, -1, modulo)
    return (sum(map(s_mod, fibonacci_generator(n))) - 1) % modulo
