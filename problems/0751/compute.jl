function compute(t::Int, n::Int)::String
    function next_b(b::Float64)::Float64
        b, a = modf(b)
        return a * (1 + b)
    end
    result = string(t, '.')
    i = 0
    while length(result) < n + 2
        x = parse(Float64, result)
        for _ ∈ 0:i x = next_b(x) end
        result = string(result, trunc(Int, x))
        i += 1
    end
    return result
end
