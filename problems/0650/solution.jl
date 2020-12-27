include("euler/Julia/primes.jl")
using .Primes: get_primes
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64, modulo::Int64 = 1000000007)::Int64
    primes = get_primes(n)
    result = ones(Int64, n)
    for prime ∈ primes
        past_super, last_super, new_super = 0, 0, 0
        last_hyper, new_hyper = 0, 0
        inverse_modulo = invmod(prime - 1, modulo)
        for i ∈ prime:n
            number = i
            j = 0
            while number % prime == 0
                j += 1
                number ÷= prime
            end
            new_super, new_hyper = last_super + j, last_hyper + i * j
            past_super = last_super = last_super + past_super
            result[i - 1] *= ((powermod(prime, last_hyper - last_super + 1, modulo) - 1) * inverse_modulo) % modulo
            result[i - 1] %= modulo
            last_super, last_hyper = new_super, new_hyper
        end
        result[n] *= ((powermod(prime, new_hyper - new_super - past_super + 1, modulo) - 1) * inverse_modulo) % modulo
        result[n] %= modulo
    end
    return sum(result) % modulo
end

compute(5)

compute(10)

compute(100)

compute(20000)

@benchmark compute(20000)