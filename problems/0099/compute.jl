function compute(path::String)::Int
    base_exp = map(x -> parse.(Int, split(x, ",")), split(read(path, String), "\n"))
    max_exponent = 0
    result = 0
    for i ∈ 1:length(base_exp)
        base, exponent = base_exp[i]
        exponent = log10(base) * exponent
        if exponent > max_exponent
            max_exponent = exponent
            result = i
        end
    end
    return result
end
