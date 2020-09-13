include("euler/Julia/big_int.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64)::Int64
    result = Big_Int("1")
    for i in 1:n
        result *= Big_Int(string(i))
    end
    return sum([parse(Int, i) for i in result.str])
end

compute(10)

compute(100)

@benchmark compute(100)