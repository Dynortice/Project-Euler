include("euler/euler.jl")
using .Numbers: count_divisors
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    i, triangle = 1, 1
    while count_divisors(triangle) < n
        i += 1
        triangle += i
    end
    return triangle
end

compute(5)

compute(500)

@benchmark compute(500)