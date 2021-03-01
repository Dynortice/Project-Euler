include("euler/euler.jl")
using .Numbers: get_digits
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

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

compute(0.5)

compute(0.9)

compute(0.99)

@benchmark compute(0.99)