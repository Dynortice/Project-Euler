using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(triangle::Array{Array{Int64,1},1})::Int64
    while length(triangle) > 1
        for i in 1:length(triangle) - 1
            triangle[end - 1][i] += maximum(triangle[end][i:i + 1])
        end
        triangle = triangle[1:end - 1]
    end
    return triangle[1][1]
end

triangle_file = map(x -> parse.(Int64, split(x, " ")), split(read("problems/0067/p067_triangle.txt", String), "\n")[1:end - 1])

compute(deepcopy(triangle_file))

@benchmark compute(deepcopy(triangle_file))