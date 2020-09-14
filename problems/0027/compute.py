from euler.primes import get_primality


def compute(max_a: int, max_b: int):
    prime = get_primality(max_a * max_b)
    primes = [i for (i, is_prime) in enumerate(prime[:max_b + 1]) if is_prime]  # all primes except 2
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
