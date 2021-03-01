using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Float64)::Int
    function is_prime_fast(x::Int)::Bool
        if x == 3
            return true
        elseif !(x % 6 == 1 || x % 6 == 5)
            return false
        end
        for i in 6:12:trunc(Int, √x)
            if x % (i - 1) == 0 || x % (i + 1) == 0 || x % (i + 7) == 0
                return false
            end
        end
        return true
    end
    j = 3
    primes = 0
    while true
        k = (j - 3)j + 3
        primes += is_prime_fast(k) + is_prime_fast(k + j - 1) + is_prime_fast(k + 2j - 2)
        if primes / (2j - 1) < n
            return j
        end
        j += 2
    end
end

compute(0.1)

@benchmark compute(0.1)
