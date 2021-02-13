def compute(n: int):
    sieve = [0] * (n + 1)
    for i in range(2, n + 1):
        sieve[i] += i - 1 - i // 2 - i // 3
        j = 2 * i
        while j <= n:
            sieve[j] -= sieve[i]
            j += i
    return sum(sieve)
