include("euler/euler.jl")
using .Calculus: triangular_numbers
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    limit = trunc(Int, √n)
    triangles = triangular_numbers(limit)
    min_difference = n
    nearest = 0
    for i ∈ 1:limit
        for j ∈ 1:i
            rectangles = triangles[i] * triangles[j]
            difference = abs(n - rectangles)
            if difference < min_difference
                min_difference = difference
                nearest = i * j
            end
            if rectangles > n break end
        end
    end
    return nearest
end

compute(18)
compute(2000000)

@benchmark compute(2000000)