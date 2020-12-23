using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64, digits::Array{Int64, 1})::String
    l = length(digits)
    result = ""
    remain = n - 1
    for i ∈ 1:l
        order = factorial(l - i)
        j = remain ÷ order + 1
        result = string(result, digits[j])
        remain %= order
        deleteat!(digits, j)
    end
    return result
end

compute(6, collect(0:2))

compute(1000000, collect(0:9))

@benchmark compute(1000000, collect(0:9))