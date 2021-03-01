function compute(digits::Int, n::Int)::Int
    digits_len = ceil(log10(digits))
    number, repetitions, result = 2, 0, 1
    while true
        result += 1
        number *= 2
        if log10(number) > digits_len number /= 10 end
        if trunc(Int64, number) == digits
            repetitions += 1
            if repetitions == n break end
        end
    end
    return result
end