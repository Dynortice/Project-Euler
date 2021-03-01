include("euler/euler.jl")
using .Calculus: champernowne_digits

function compute(n::Int)::Int
    result = 1
    for i ∈ 0:9
        j, k = 10 ^ i, 0
        while champernowne_digits(k + 1) < j
            k += 1
        end
        k += 1
        remainder = j - champernowne_digits(k - 1)
        number = 10 ^ (k - 1) + remainder ÷ k - 1
        if remainder % k == 0
            result *= parse(Int, string(number)[end])
        else
            result *= parse(Int, string(number + 1)[remainder % k])
        end
    end
    return result
end