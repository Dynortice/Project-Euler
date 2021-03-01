include("euler/euler.jl")
using .Calculus: fibonacci_index, fibonacci_numbers

function compute(n::Int)::Int
    index = fibonacci_index(n)
    fibonacci = fibonacci_numbers(index, Int)
    last_sum, new_sum = 0, 0
    result = sum(fibonacci[1:5]) - 1
    for i ∈ 6:index + 1
        last_sum, new_sum = new_sum, new_sum + last_sum + fibonacci[i - 3]
        result += new_sum + fibonacci[i]
    end
    return result
end
