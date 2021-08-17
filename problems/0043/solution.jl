include("euler/euler.jl")
using .Primes: prime_numbers
using Combinatorics: permutations
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    function get_permutation_numbers(used::Vector{Int}, prime_index::Int)::Int
        sub_result = 0
        for i ∈ setdiff(digits, used)
            if parse(Int, string(i, join(used[1:2]))) % primes[prime_index] == 0
                if prime_index < 7
                    sub_result += get_permutation_numbers(vcat(i, used), prime_index + 1)
                else
                    used_digits = vcat(i, used)
                    sub_result += parse(Int, join(vcat(setdiff(digits, used_digits), used_digits)))
                end
            end
        end
        return sub_result
    end
    digits = collect(0:n)
    primes = reverse(prime_numbers(17))
    result = 0
    for permutation ∈ permutations(digits, 3)
        if parse(Int, join(permutation)) % primes[10 - n] == 0
            result += get_permutation_numbers(permutation, 11 - n)
        end
    end
    return result
end

compute(9)

@benchmark compute(9)