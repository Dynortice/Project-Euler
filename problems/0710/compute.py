def compute(modulo: int) -> int:
    n = (4, 2, 1)
    power = i = 4
    result = 1
    while result:
        n = (2 * n[0] - n[1] + n[2]) % modulo, n[0], n[1]
        power = power * 2 % modulo
        result = power - n[1]
        i += 2
    return i
