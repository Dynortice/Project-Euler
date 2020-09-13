include("euler/Julia/numbers.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Integer)::Integer
    i, triangle = 1, 1
    while numbers.count_divisors(triangle) < n
        i += 1
        triangle += i
    end
    return triangle
end

compute(5)

compute(500)

@benchmark compute(500)