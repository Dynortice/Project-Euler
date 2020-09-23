include("euler/Julia/big_int.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64)::Int64
    max_sum = 0
    for a ∈ 1:n - 1
        number = Big_Int(string(a))
        for b ∈ 1:n - 1
            number *= Big_Int(string(a))
            max_sum = max(max_sum, sum(parse.(Int, collect(number.str))))
        end
    end
    return max_sum
end

compute(100)

@benchmark compute(100)