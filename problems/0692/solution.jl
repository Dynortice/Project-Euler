include("euler/euler.jl")
using .Calculus: fibonacci_index, fibonacci_numbers
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    index = fibonacci_index(n)
    fibonacci = fibonacci_numbers(index + 1, Int)
    last_sum, new_sum = 0, 0
    result = sum(fibonacci[1:4]) - 1
    for i ∈ 5:index
        last_sum, new_sum = new_sum, new_sum + last_sum + fibonacci[i - 3]
        result += new_sum + fibonacci[i]
    end
    return result
end

compute(13)

compute(23_416_728_348_467_685)

@benchmark compute(23_416_728_348_467_685)