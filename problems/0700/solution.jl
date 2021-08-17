using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

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

compute(1_504_170_715_041_707, 4_503_599_627_370_517)

@benchmark compute(1_504_170_715_041_707, 4_503_599_627_370_517)