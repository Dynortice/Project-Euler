include("euler/euler.jl")
using .Primes: prime_sieve
import StatsBase: countmap
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    sieve = prime_sieve(10 ^ (n - 1))
    for (number, is_prime) ∈ enumerate(sieve)
        if !is_prime || number < 10 continue end
        most_common = findmax(countmap(collect(string(number)[1:end - 1])))
        if most_common[1] == 1 && parse(Int, most_common[2]) > 9 - n continue end
        if sum(sieve[map(x->parse(Int, replace(string(number), most_common[2] => x)), parse(Int, most_common[2]):9)]) ≥ n return number end
    end
end

compute(7)

compute(8)

@benchmark compute(8)