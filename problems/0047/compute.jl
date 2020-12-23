include("euler/Julia/primes.jl")
using .Primes: get_primes

function compute(n::Int64)::Int64
    prime_numbers = get_primes(10 ^ n ÷ n)
    consecutive = 0
    i = 10 ^ (n - 1)
    while true
        if i ∈ prime_numbers
            consecutive = 0
        else
            prime_factors = 0
            t = i
            for prime ∈ prime_numbers
                if t % prime == 0
                    prime_factors += 1
                    t ÷= prime
                end
                if (prime > t) | (t == 1) | (prime_factors == n)
                    break
                end
            end
            if prime_factors == n
                consecutive += 1
            else
                consecutive = 0
            end
        end
        if consecutive == n
            return i - n + 1
        end
        i += 1
    end
end