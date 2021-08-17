include("euler/euler.jl")
using .Primes: prime_numbers
using .Numbers: sum_proper_divisors
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int
    n = 28_123
    primes = prime_numbers(trunc(Int, √n))
    abundant_sieve, not_expressible = repeat([false], n), repeat([true], n)
    result = 0
    for i ∈ 1:n
        abundant_sieve[i] = i < sum_proper_divisors(i, primes)
        for j ∈ 1:i ÷ 2
            if abundant_sieve[j] && abundant_sieve[i - j]
                not_expressible[i] = false
                break
            end
        end
        if not_expressible[i] result += i end
    end
    return result
end

compute()

@benchmark compute()