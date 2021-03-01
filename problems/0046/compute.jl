include("euler/euler.jl")
using .Calculus: is_square
using .Primes: prime_sieve

function compute()::Int
    sieve = prime_sieve(6000)
    prime_numbers = findall(sieve)
    i = 9
    while true
        if !sieve[i]
            j = 1
            is_not_expressible = true
            while prime_numbers[j] < i
                if is_square((i - prime_numbers[j]) ÷ 2)
                    is_not_expressible = false
                    break
                end
                j += 1
            end
            if is_not_expressible return i end
        end
        i += 2
    end
end