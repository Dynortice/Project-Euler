include("euler/Julia/calculus.jl")
using .Calculus: sum_arithmetic_series

function compute(a::Int64, b::Int64, n::Int64)::Int64
    n -= 1
    return sum([sum_arithmetic_series(a, a, n ÷ a), sum_arithmetic_series(b, b, n ÷ b),
                - sum_arithmetic_series(a * b, a * b, n ÷ (a * b))])
end