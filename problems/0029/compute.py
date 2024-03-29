from math import isqrt, log, log2


def compute(n: int) -> int:
    limit_powers, limit_numbers = int(log2(n)), isqrt(n)
    power_counts = [0] * (limit_powers + 1)
    for i in range(2, limit_numbers + 1):
        power = int(log(n, i))
        power_counts[power] += 1
        j = i * i
        while j <= limit_numbers:
            power_counts[int(log(n, j))] -= 1
            j *= i
    sieve = [False] * (limit_powers * n + 1)
    duplicate_counts = [0] * (limit_powers + 1)
    count = 0
    for i in range(1, limit_powers + 1):
        for j in range(2, n + 1):
            if sieve[i * j]:
                count += 1
            else:
                sieve[i * j] = True
        duplicate_counts[i] = count
    return (n - 1) ** 2 - sum(x * y for x, y in zip(power_counts, duplicate_counts))
