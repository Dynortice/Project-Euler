include("../euler/Julia/calculus.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Integer)
    return trunc(Int, calculus.fibonacci_number(calculus.fibonacci_index(n) + 2) / 2)
end

compute(4000000)

@benchmark compute(4000000)
