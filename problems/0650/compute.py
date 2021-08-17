from euler.primes import prime_numbers


def compute(n: int, m: int = 1_000_000_007) -> int:
    result = [0] + [1] * n
    for prime in prime_numbers(n):
        past_super, last_super, new_super = 0, 0, 0
        last_hyper, new_hyper = 0, 0
        inv_mod = pow(prime - 1, -1, m)
        for i in range(prime, n + 1):
            number = i
            j = 0
            while number % prime == 0:
                j += 1
                number //= prime
            new_super, new_hyper = last_super + j, last_hyper + i * j
            past_super = last_super = last_super + past_super
            result[i - 1] *= ((pow(prime, last_hyper - last_super + 1, m) - 1) * inv_mod) % m
            result[i - 1] %= m
            last_super, last_hyper = new_super, new_hyper
        result[n] *= ((pow(prime, new_hyper - new_super - past_super + 1, m) - 1) * inv_mod) % m
        result[n] %= m
    return sum(result) % m
