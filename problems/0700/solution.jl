using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int
    modulo = 4503599627370517
    min_value = max_value = result = 1504170715041707
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

compute()

@benchmark compute()