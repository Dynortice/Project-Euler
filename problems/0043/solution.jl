using Combinatorics
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64)::Int64
    digits_ = collect(0:n)
    primes = [17, 13, 11, 7, 5, 3, 2]
    result = 0

    function get_permutation_numbers(used::Array{Int64, 1}, nth_prime::Int64)::Int64
        sub_result = 0
        for i in setdiff(digits_, used)
            if parse(Int64, string(i, join(used[1:2]))) % primes[nth_prime] ≡ 0
                if nth_prime < 7
                    sub_result += get_permutation_numbers(vcat(i, used), nth_prime + 1)
                else
                    used_digits = vcat(i, used)
                    sub_result += parse(Int64, join(vcat(setdiff(digits_, used_digits), used_digits)))
                end
            end
        end
        return sub_result
    end

    for permutation in Combinatorics.permutations(digits_, 3)
        if parse(Int64, join(permutation)) % primes[9 - n + 1] ≡ 0
            result += get_permutation_numbers(permutation, 9 - n + 2)
        end
    end

    return result
end

compute(9)

@benchmark compute(9)