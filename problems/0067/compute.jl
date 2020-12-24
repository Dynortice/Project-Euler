function compute(path::String)::Int64
    triangle = map(x -> parse.(Int64, split(x, " ")), split(read(path, String), "\n"))
    while length(triangle) > 1
        for i ∈ 1:length(triangle) - 1
            triangle[end - 1][i] += maximum(triangle[end][i:i + 1])
        end
        triangle = triangle[1:end - 1]
    end
    return triangle[1][1]
end