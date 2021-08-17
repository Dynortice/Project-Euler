include("euler/euler.jl")
import StatsBase: countmap
using .BigIntegers: BigInteger
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int, modulo::Int)::BigInteger
    function get_digits(k::Int, limit::Int)::Vector{Vector{Int}}
        result = Vector{Vector{Int}}()
        if k ≤ 0 return result end
        if k ≤ limit append!(result, [[k]]) end
        for i ∈ 1:limit for j ∈ get_digits(k - i, i) append!(result, [vcat(i, j)]) end end
        return result
    end
    factorials = Dict{Int, BigInteger}()
    all_digits = BigInteger(invmod(9, modulo)) * BigInteger((powermod(10, n, modulo) - 1)) % modulo
    total = BigInteger(0)
    for digit ∈ 1:9
        for other_digits ∈ get_digits(digit, digit)
            len_digits = length(other_digits)
            if n - len_digits - 1 < 0 continue end
            digits = countmap(vcat(digit, other_digits))
            for m ∈ keys(digits)
                partial_digits = copy(digits)
                partial_digits[m] -= 1
                if !haskey(factorials, len_digits) factorials[len_digits] = prod(BigInteger(n - i - 1) for i ∈ 0:len_digits - 1) end
                multinomial = factorials[len_digits]
                for p ∈ values(partial_digits) multinomial ÷= factorial(p) end
                total += all_digits * m * multinomial
            end
        end
        total %= modulo
    end
    return total
end

compute(3, 10_000_000_000_000_000)

compute(7, 10_000_000_000_000_000)

compute(2_020, 10_000_000_000_000_000)

@benchmark compute(2_020, 10_000_000_000_000_000)