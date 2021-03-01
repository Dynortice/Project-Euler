include("euler/euler.jl")
using .Primes: prime_numbers

function compute(n::Int, m::Int = 1000000007)::Int
    result = ones(Int, n)
    for prime ∈ prime_numbers(n)
        past_super, last_super, new_super = 0, 0, 0
        last_hyper, new_hyper = 0, 0
        inv_mod = invmod(prime - 1, m)
        for i ∈ prime:n
            number, j = i, 0
            while number % prime == 0
                j += 1
                number ÷= prime
            end
            new_super, new_hyper = last_super + j, last_hyper + i * j
            past_super = last_super = last_super + past_super
            result[i - 1] *= ((powermod(prime, last_hyper - last_super + 1, m) - 1) * inv_mod) % m
            result[i - 1] %= m
            last_super, last_hyper = new_super, new_hyper
        end
        result[n] *= ((powermod(prime, new_hyper - new_super - past_super + 1, modulo) - 1) * inv_mod) % m
        result[n] %= m
    end
    return sum(result) % m
end
