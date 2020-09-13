include("euler/Julia/primes.jl")
include("euler/Julia/numbers.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int64
    n = 28123
    primes_numbers = primes.get_primes(trunc(Int, √n))
    abundant_sieve, not_expressible = repeat([false], n), repeat([true], n)
    result = 0
    for i in 1:n
        abundant_sieve[i] = i < numbers.sum_proper_factors(i, primes_numbers)
        for j in 1:i ÷ 2
            if abundant_sieve[j] & abundant_sieve[i - j]
                not_expressible[i] = false
                break
            end
        end
        if not_expressible[i]
            result += i
        end
    end
    return result
end

compute()

@benchmark compute()