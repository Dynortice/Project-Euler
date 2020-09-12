include("../euler/Julia/calculus.jl")

function compute(n::Integer)
    return trunc(Int, calculus.fibonacci_number(calculus.fibonacci_index(n) + 2) / 2)
end
