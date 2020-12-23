include("euler/Julia/primes.jl")
using .Primes: get_primality

function compute(n::Int64)::Int64
    sieve = get_primality(n)
    prime_numbers = findall(sieve)
    result = 0
    for prime ∈ prime_numbers
        str_prime = string(prime)
        is_circular_prime = true
        for _ ∈ 1:length(str_prime)
            str_prime = string(str_prime[2:end], str_prime[1])
            if !sieve[parse(Int, str_prime)]
                is_circular_prime = false
                break
            end
        end
        if is_circular_prime
            result += 1
        end
    end
    return result
end