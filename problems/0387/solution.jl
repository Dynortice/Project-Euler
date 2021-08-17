include("euler/euler.jl")
using .Numbers: digits_sum
using .Primes: is_prime
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    harshad_numbers = collect(1:9)
    result = 0
    for _ ∈ 1:n - 2
        new_harshad_numbers = Vector{Int}()
        for i ∈ 0:9
            for harshad ∈ harshad_numbers
                if (harshad * 10 + i) % (digits_sum(harshad) + i) == 0
                    new_harshad = harshad * 10 + i
                    push!(new_harshad_numbers, new_harshad)
                    if is_prime(new_harshad ÷ digits_sum(new_harshad)) for j ∈ [1, 3, 7, 9] if is_prime(new_harshad * 10 + j) result += new_harshad * 10 + j end end end
                end
            end
        end
        harshad_numbers = new_harshad_numbers
    end
    return result
end

compute(4)

compute(14)

@benchmark compute(14)