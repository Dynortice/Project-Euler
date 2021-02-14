function compute(path::String)::Int64
    get_area(ax::Int64, ay::Int64, bx::Int64, by::Int64, cx::Int64, cy::Int64)::Float64 = abs((ax - cx) * (by - ay) - (ax - bx) * (cy - ay)) / 2
    triangles = map(x -> parse.(Int64, split(x, ",")), split(read(path, String), "\n"))
    x = [0, 0]
    result = 0
    for △ ∈ triangles
        a, b, c = △[1:2], △[3:4], △[5:6]
        if get_area(△...) == sum([get_area(a..., b..., x...), get_area(a..., x..., c...), get_area(x..., b..., c...)])
            result += 1
        end
    end
    return result
end
