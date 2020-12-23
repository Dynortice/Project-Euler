include("euler/Julia/primes.jl")
using .Primes: get_primality
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int64
    function check_truncatable_prime(n::Int64)::Bool
        p = 10
        while p < n
            if sieve[n % p] & sieve[n ÷ p]
                p *= 10
            else
                return false
            end
        end
        return true
    end
    sieve = get_primality(1000000)
    prime_numbers = findall(sieve)[5:end]
    truncatable_primes = 0
    i = 1
    result = 0
    while truncatable_primes < 11
        if check_truncatable_prime(prime_numbers[i])
            truncatable_primes += 1
            result += prime_numbers[i]
        end
        i += 1
    end
    return result
end

compute()

@benchmark compute()