function compute(triangle::AbstractString)::Int64
    triangle = [parse.(Int, split(line, " ")) for line in split(triangle, "\n")]
    while length(triangle) > 1
        for i in 1:length(triangle) - 1
            triangle[end - 1][i] += maximum(triangle[end][i:i + 1])
        end
        triangle = triangle[1:end - 1]
    end
    return triangle[1][1]
end
