include("euler/Julia/numbers.jl")
include("euler/Julia/primes.jl")
using .Numbers: digits_sum
using .Primes: is_prime

function compute(n::Int64)::Int64
    harshad_numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    result = 0
    for _ ∈ 1:n - 2
        new_harshad_numbers = Array{Int64, 1}()
        for i ∈ 0:9
            for harshad ∈ harshad_numbers
                if (harshad * 10 + i) % (digits_sum(harshad) + i) == 0
                    new_harshad = harshad * 10 + i
                    push!(new_harshad_numbers, new_harshad)
                    if is_prime(new_harshad ÷ digits_sum(new_harshad))
                        for j ∈ [1, 3, 7, 9]
                            if is_prime(new_harshad * 10 + j)
                                result += new_harshad * 10 + j
                            end
                        end
                    end
                end
            end
        end
        harshad_numbers = new_harshad_numbers
    end
    return result
end
