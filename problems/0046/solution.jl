include("euler/Julia/primes.jl")
include("euler/Julia/numbers.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int64
    sieve = primes.get_primality(6000)
    prime_numbers = findall(sieve)
    i = 9
    while true
        if !sieve[i]
            j = 1
            is_not_expressible = true
            while prime_numbers[j] < i
                if numbers.is_perfect_square((i - prime_numbers[j]) ÷ 2)
                    is_not_expressible = false
                    break
                end
                j += 1
            end
            if is_not_expressible
                return i
            end
        end
        i += 2
    end
end

compute()

@benchmark compute()