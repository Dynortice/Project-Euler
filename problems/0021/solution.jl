include("euler/Julia/primes.jl")
include("euler/Julia/numbers.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Integer)::Integer
    sum_factors = repeat([0], n)
    primes_numbers = primes.get_primes(trunc(Int, √n))
    result = 0
    for i in 1:n
        sum_factors[i] = trunc(Int, numbers.sum_proper_factors(i, primes_numbers))
    end
    for i in 2:n
        j = sum_factors[i]
        if (j ≠ i) & (j ≤ n)
            if sum_factors[j] ≡ i
                result += i
            end
        end
    end
    return result
end

compute(1000)

compute(10000)

@benchmark compute(10000)