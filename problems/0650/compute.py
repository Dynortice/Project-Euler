from euler.primes import get_primes


def compute(n: int, modulo: int = 1000000007) -> int:
    primes = get_primes(n)
    result = [0] + [1] * n
    for prime in primes:
        past_super, last_super, new_super = 0, 0, 0
        last_hyper, new_hyper = 0, 0
        inverse_modulo = pow(prime - 1, -1, modulo)
        for i in range(prime, n + 1):
            number = i
            j = 0
            while number % prime == 0:
                j += 1
                number //= prime
            new_super, new_hyper = last_super + j, last_hyper + i * j
            past_super = last_super = last_super + past_super
            result[i - 1] *= ((pow(prime, last_hyper - last_super + 1, modulo) - 1) * inverse_modulo) % modulo
            result[i - 1] %= modulo
            last_super, last_hyper = new_super, new_hyper
        result[n] *= ((pow(prime, new_hyper - new_super - past_super + 1, modulo) - 1) * inverse_modulo) % modulo
        result[n] %= modulo
    return sum(result) % modulo
