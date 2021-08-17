include("euler/euler.jl")
using .Primes: prime_sieve

function compute()::Int
    sieve = prime_sieve(1_000_000)
    primes = findall(sieve)[5:end]
    truncatable, result = 0, 0
    for prime in primes
        p, is_truncatable = 10, true
        while p < prime
            if sieve[prime % p] && sieve[prime ÷ p]
                p *= 10
            else
                is_truncatable = false
                break
            end
        end
        if is_truncatable
            truncatable += 1
            result += prime
            if truncatable == 11
                break
            end
        end
    end
    return result
end