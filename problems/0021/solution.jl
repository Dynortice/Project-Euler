include("euler/euler.jl")
using .Primes: prime_numbers
using .Numbers: sum_proper_divisors
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    sum_factors = repeat([0], n)
    primes_numbers = prime_numbers(trunc(Int, √n))
    result = 0
    for i ∈ 1:n sum_factors[i] = trunc(Int, sum_proper_divisors(i, primes_numbers)) end
    for i ∈ 2:n
        j = sum_factors[i]
        if j ≠ i && j ≤ n && sum_factors[j] == i result += i end
    end
    return result
end

compute(1000)

compute(10000)

@benchmark compute(10000)