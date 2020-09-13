function compute(n::Int64, digits::Array{Int64, 1})::String
    l = length(digits)
    result = ""
    remain = n - 1
    for i in 1:l
        order = factorial(l - i)
        j = remain ÷ order + 1
        result = string(result, digits[j])
        remain %= order
        deleteat!(digits, j)
    end
    return result
end
