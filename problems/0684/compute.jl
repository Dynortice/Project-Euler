include("euler/Julia/calculus.jl")
using .Calculus: BigInteger, get_fibonacci

function compute(n::Int64, modulo::Int64)
    function s_mod(k::BigInteger)::BigInteger
        a, b = k % 9 + 2, k ÷ 9
        return ((a * (a - 1) + 10) * powermod(BigInteger(10), b, modulo) - 2(a + 9b + 4)) * inverted_modulo % modulo
    end
    inverted_modulo = invmod(2, modulo)
    return (sum(s_mod.(get_fibonacci(n))) - 1) % modulo
end
