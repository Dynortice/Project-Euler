function compute(triangle::Array{Array{Int64,1},1})::Int64
    while length(triangle) > 1
        for i ∈ 1:length(triangle) - 1
            triangle[end - 1][i] += maximum(triangle[end][i:i + 1])
        end
        triangle = triangle[1:end - 1]
    end
    return triangle[1][1]
end