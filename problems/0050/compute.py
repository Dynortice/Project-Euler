from euler.primes import get_primality


def compute(n: int) -> int:
    sieve = get_primality(n)
    primes = [i for (i, is_prime) in enumerate(sieve) if is_prime]
    max_sequence, max_sequence_sum = 0, 0
    for i in primes:
        max_sequence_sum += i
        if max_sequence_sum < n:
            max_sequence += 1
        else:
            break
    for i in reversed(range(max_sequence)):
        for j in range(len(primes) - i + 1):
            sum_sequence = sum(primes[j:i + j + 1])
            if sum_sequence > n:
                break
            elif sieve[sum_sequence]:
                return sum_sequence
