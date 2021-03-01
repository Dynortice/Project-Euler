include("euler/euler.jl")
using .Calculus: sum_arithmetic_series

function compute(a::Int, b::Int, n::Int)::Int
    n -= 1
    ab = a * b
    return sum_arithmetic_series(a, a, n ÷ a) + sum_arithmetic_series(b, b, n ÷ b) - sum_arithmetic_series(ab, ab, n ÷ ab)
end