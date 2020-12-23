include("euler/Julia/primes.jl")
using .Primes: get_primality

function compute(max_a::Int64, max_b::Int64)::Int64
    prime = get_primality(max_a * max_b)
    prime_numbers = findall(prime[1:max_b])
    append!(prime_numbers, .-prime_numbers)
    max_sequence, result = 0, 0
    for a ∈ -max_a + (max_a % 2 ≡ 0 ? 1 : 2):2:max_a - 1
        for b ∈ prime_numbers
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
