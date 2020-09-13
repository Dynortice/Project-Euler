include("euler/Julia/numbers.jl")

function compute(n::Integer)::Integer
    i, triangle = 1, 1
    while numbers.count_divisors(triangle) < n
        i += 1
        triangle += i
    end
    return triangle
end
