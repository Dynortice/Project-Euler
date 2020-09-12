include("euler/Julia/calculus.jl")

function compute(a::Integer, b::Integer, n::Integer)
    n -= 1
    return sum([calculus.sum_arithmetic_series(a, a, n ÷ a),
                calculus.sum_arithmetic_series(b, b, n ÷ b),
                - calculus.sum_arithmetic_series(a * b, a * b, n ÷ (a * b))])
end