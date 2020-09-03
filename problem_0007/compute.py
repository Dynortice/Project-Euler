from euler.primes import get_primes


def compute(n: int) -> int:
    return get_primes(n * 20)[n - 1]
