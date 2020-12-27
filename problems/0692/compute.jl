include("euler/Julia/calculus.jl")
using .Calculus: fibonacci_index, get_fibonacci

function compute(n::Int64)::Int64
    index = fibonacci_index(n)
    fibonacci = get_fibonacci(index, Int64)
    last_sum, new_sum = 0, 0
    result = sum(fibonacci[1:5]) - 1
    for i ∈ 6:index + 1
        last_sum, new_sum = new_sum, new_sum + last_sum + fibonacci[i - 3]
        result += new_sum + fibonacci[i]
    end
    return result
end
