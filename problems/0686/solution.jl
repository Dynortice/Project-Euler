using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(digits_::Int64, n::Int64)::Int64
    digits_len = ceil(log10(digits_))
    number = 2
    repetitions = 0
    result = 1
    while true
        result += 1
        number *= 2
        if log10(number) > digits_len
            number /= 10
        end
        if trunc(Int64, number) == digits_
            repetitions += 1
            if repetitions == n
                break
            end
        end
    end
    return result
end

compute(12, 1)

compute(12, 2)

compute(123, 45)

compute(123, 678910)

@benchmark compute(123, 678910)