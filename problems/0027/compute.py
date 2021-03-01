from euler.primes import prime_sieve


def compute(max_a: int, max_b: int):
    prime = prime_sieve(max_a * max_b)
    primes = [i for (i, is_prime) in enumerate(prime[:max_b + 1]) if is_prime]
    primes += [-prime for prime in primes]
    max_sequence, result = 0, 0
    for b in primes:
        for a in range(-max_a + 1, max_a, 2):
            n = 0
            while True:
                if not prime[abs(n * (n + a) + b)]:
                    break
                n += 1
            if n > max_sequence:
                max_sequence, result = n, a * b
    return result
