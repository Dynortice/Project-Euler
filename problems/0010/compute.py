from euler.primes import get_primes


def compute(n: int) -> int:
    return sum(get_primes(n))
