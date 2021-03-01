function compute(n::Int, digits::Array{Int, 1})::String
    k = length(digits)
    result = ""
    remain = n - 1
    for i ∈ 1:k
        order = factorial(k - i)
        j = remain ÷ order + 1
        result = string(result, digits[j])
        remain %= order
        deleteat!(digits, j)
    end
    return result
end
