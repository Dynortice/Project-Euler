include("euler/euler.jl")
using .BigIntegers: BigInteger
using .Calculus: fibonacci_numbers
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int, m::Int = 1_000_000_007)
    inverted_modulo = invmod(2, m)
    result = BigInteger(-1)
    for f ∈ fibonacci_numbers(n, BigInteger)
        a, b = f % 9 + 2, f ÷ 9
        result += ((a * (a - 1) + 10) * powermod(BigInteger(10), b, m) - 2(a + 9b + 4)) * inverted_modulo % m
    end
    return result % m
end

compute(90)

@benchmark compute(90)