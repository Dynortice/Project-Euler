include("euler/euler.jl")
using .Numbers: is_s_number

function compute(n::Int)::Int
    result = 0
    for i ∈ 2:n if is_s_number(i, i * i) result += i * i end end
    return result
end
