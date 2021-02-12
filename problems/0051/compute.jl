include("euler/Julia/primes.jl")
import StatsBase: countmap
using .Primes: get_primality

function compute(n::Int64)::Int64
    get_family(candidate::String, digit::SubString{String}) = [parse(Int64, replace(candidate, digit => i)) for i ∈ parse(Int64, digit):9]
    sieve = get_primality(10 ^ (n - 1))
    for (number, is_prime) ∈ enumerate(sieve)
        if !is_prime | number < 10
            continue
        end
        most_common = findmax(countmap(split(string(number), "")))
        if most_common[1] == 1 & parse(Int64, most_common[2]) > 9 - n
            continue
        end
        if sum(sieve[get_family(string(number), most_common[2])]) ≥ n
            return number
        end
    end
    return n
end
