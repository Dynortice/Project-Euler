include("euler/euler.jl")
using .Primes: prime_numbers

function compute(n::Int)::Int
    primes = prime_numbers(10 ^ n ÷ n)
    consecutive = 0
    i = 10 ^ (n - 1)
    while true
        if i ∈ primes
            consecutive = 0
        else
            divisors = 0
            t = i
            for prime ∈ primes
                if t % prime == 0
                    divisors += 1
                    t ÷= prime
                end
                if prime > t || t == 1 || divisors == n
                    break
                end
            end
            if divisors == n
                consecutive += 1
            else
                consecutive = 0
            end
        end
        if consecutive == n return i - n + 1 end
        i += 1
    end
end