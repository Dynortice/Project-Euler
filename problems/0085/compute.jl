include("euler/euler.jl")
using .Calculus: triangular_numbers

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
