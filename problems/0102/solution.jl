include("euler/euler.jl")
using .Geometry: triangle_area
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(path::String)::Int
    triangles = map(x -> parse.(Int, split(x, ",")), split(read(path, String), "\n"))
    x = [0, 0]
    result = 0
    for △ ∈ triangles
        a, b, c = △[1:2], △[3:4], △[5:6]
        if triangle_area(a, b, x) + triangle_area(a, x, c) + triangle_area(x, b, c) == triangle_area(a, b, c) result += 1 end
    end
    return result
end

compute("problems/0102/p102_triangles.txt")

@benchmark compute("problems/0102/p102_triangles.txt")