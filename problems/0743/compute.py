def compute(k: int, n: int, modulo: int = 1_000_000_007) -> int:
    result, binomial, s = 0, 1, k
    power = pow(2, n, modulo)
    power_inv = pow(pow(4, n // k, modulo), -1, modulo)
    for i in range(1, k // 2 + 2):
        result = (result + binomial * power) % modulo
        binomial = binomial * s % modulo * (s - 1) % modulo * pow(pow(i, -1, modulo), 2, modulo) % modulo
        s -= 2
        power = (power * power_inv) % modulo
    return result
