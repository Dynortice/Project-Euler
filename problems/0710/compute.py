def compute(mod: int) -> int:
    def get_next_n(*args: int) -> int:
        return (2 * args[0] - args[1] + args[2]) % mod
    n = (4, 2, 1)
    power = 4
    i = 4
    result = 1
    while result:
        n = get_next_n(*n), n[0], n[1]
        power = power * 2 % mod
        result = power - n[1]
        if i == 24:
            return i, power, n
        i += 2
    return i

compute(100)