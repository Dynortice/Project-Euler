include("euler/Julia/primes.jl")
using .Primes: get_primality
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64)::Int64
    sieve = get_primality(n)
    candidates = [i - 1 for (i, is_prime) ∈ enumerate(sieve) if is_prime & ((i - 1) % 4 != 0)]
    result = 0
    for candidate ∈ candidates
        if !sieve[candidate ÷ 2 + 2]
            continue
        end
        is_valid = true
        for i ∈ 3:trunc(Int64, √n + 1)
            if candidate % i ≠ 0
                continue
            elseif !sieve[candidate ÷ i + i]
                is_valid = false
                break
            end
        end
        if is_valid
            result += candidate
        end
    end
    return result
end

compute(100000000)

@benchmark compute(100000000)