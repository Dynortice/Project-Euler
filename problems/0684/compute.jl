include("euler/euler.jl")
using .BigIntegers: BigInt
using .Calculus: fibonacci_numbers

function compute(n::Int, m::Int)
    inverted_modulo = invmod(2, m)
    result = BigInteger(-1)
    for f ∈ fibonacci_numbers(n, BigInteger)
        a, b = f % 9 + 2, f ÷ 9
        result += ((a * (a - 1) + 10) * powermod(BigInteger(10), b, m) - 2(a + 9b + 4)) * inverted_modulo % m
    end
    return result % m
end
