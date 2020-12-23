include("euler/Julia/primes.jl")
include("euler/Julia/numbers.jl")
using .Primes: get_primes
using .Numbers: sum_proper_factors

function compute(n::Int64)::Int64
    sum_factors = repeat([0], n)
    primes_numbers = get_primes(trunc(Int, √n))
    result = 0
    for i ∈ 1:n
        sum_factors[i] = trunc(Int, sum_proper_factors(i, primes_numbers))
    end
    for i ∈ 2:n
        j = sum_factors[i]
        if (j ≠ i) & (j ≤ n)
            if sum_factors[j] == i
                result += i
            end
        end
    end
    return result
end
