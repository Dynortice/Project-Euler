include("euler/euler.jl")
using .Numbers: count_divisors

function compute(n::Int)::Int
    i, triangle = 1, 1
    while count_divisors(triangle) < n
        i += 1
        triangle += i
    end
    return triangle
end
