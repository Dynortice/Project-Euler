include("euler/euler.jl")
using .Numbers: get_digits

function compute(n::Float64)::Int
    bouncy = 0
    i = 1
    while bouncy / i < n
        i += 1
        digits = get_digits(i)
        sorted_digits = sort(digits)
        if !(digits == sorted_digits || digits == reverse(sorted_digits)) bouncy += 1 end
    end
    return i
end
