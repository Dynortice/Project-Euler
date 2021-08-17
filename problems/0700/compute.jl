function compute(first::Int, modulo::Int)::Int
    min_value = max_value = result = first
    candidate = 0
    while candidate ≠ 1
        candidate = (min_value + max_value) % modulo
        if candidate > max_value
            max_value = candidate
        elseif candidate < min_value
            min_value = candidate
            result += candidate
        end
    end
    return result
end