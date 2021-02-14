function compute(n::Int64)::Int64
    limit = trunc(Int64, √n)
    triangles = ones(Int64, limit)
    for i ∈ 2:limit
        triangles[i] = triangles[i - 1] + i
    end
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
            if rectangles > n
                break
            end
        end
    end
    return nearest
end
