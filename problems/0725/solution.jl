include("euler/Julia/big_int.jl")
import StatsBase: countmap
using .BigIntegers: BigInteger
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64, modulo::Int64)::BigInteger
    function digit_sum(k::Int64, limit::Int64)::Array{Array{Int64, 1}, 1}
        result = Array{Array{Int64, 1}, 1}()
        if k ≤ 0
            return result
        end
        if k ≤ limit
            append!(result, [[k]])
        end
        for i ∈ 1:limit
            for j ∈ digit_sum(k - i, i)
                append!(result, [vcat(i, j)])
            end
        end
        return result
    end
    function reverted_factorial(k::Int64)::BigInteger
        if !haskey(factorials, k)
            result = BigInteger(1)
            for i ∈ 0:k - 1
                result *= n - i - 1
            end
            factorials[k] = result
        end
        return factorials[k]
    end
    factorials = Dict{Int64, BigInteger}()
    all_digits = BigInteger(invmod(9, modulo)) * BigInteger((powermod(10, n, modulo) - 1)) % modulo
    total = BigInteger(0)
    for digit ∈ 1:9
        for other_digits ∈ digit_sum(digit, digit)
            if n - length(other_digits) - 1 < 0
                continue
            end
            digits = countmap(vcat(digit, other_digits))
            for m ∈ keys(digits)
                partial_digits = copy(digits)
                partial_digits[m] -= 1
                multinomial = reverted_factorial(length(other_digits))
                for p ∈ values(partial_digits)
                    multinomial ÷= factorial(p)
                end
                total += all_digits * m * multinomial
            end
        end
        total %= modulo
    end
    return total
end

compute(3, 10 ^ 16)
compute(7, 10 ^ 16)
compute(2020, 10 ^ 16)

@benchmark compute(2020, 10 ^ 16)