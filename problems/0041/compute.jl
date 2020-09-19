include("euler/Julia/primes.jl")

function compute()::Int64
    prime_numbers = primes.get_primes(7654321)
    for prime in reverse(prime_numbers)
        str_prime = string(prime)
        if sort(parse.(Int64, ∪(str_prime))) == collect(1:length(str_prime))
            return prime
        end
    end
end
