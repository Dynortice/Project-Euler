include("euler/Julia/primes.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(max_a::Int64, max_b::Int64)::Int64
    prime = primes.get_primality(max_a * max_b)
    prime_numbers = findall(prime[1:max_b])
    append!(prime_numbers, .-prime_numbers)
    max_sequence, result = 0, 0
    for a in -max_a + (max_a % 2 ≡ 0 ? 1 : 2):2:max_a - 1
        for b in prime_numbers
            n = 0
            while true
                candidate = abs(n * (n + a) + b)
                if candidate ≠ 0
                    if !prime[candidate]
                        break
                    end
                else
                    break
                end
                n += 1
            end
            if n > max_sequence
                max_sequence, result = n, a * b
            end
        end
    end
    return result
end

compute(1000, 1000)

@benchmark compute(1000, 1000)