include("euler/Julia/primes.jl")
include("euler/Julia/numbers.jl")

function compute(n::Int64)::Int64
    prime_numbers = primes.get_primes(n)[3:end]
    max_cycle, result = 0, 0
    for prime in prime_numbers
        cycle = numbers.multiplicative_order(10, prime)
        if cycle > max_cycle
            max_cycle, result = cycle, prime
        end
    end
    return result
end
