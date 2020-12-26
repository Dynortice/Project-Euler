module Primes

    export get_primality, get_primes, smallest_prime_factor, is_prime

    function get_primality(n::Int64)::Array{Bool, 1}
        sieve = repeat([true], n)
        sieve[1] = false
        for i ∈ 4:2:n
            sieve[i] = false
        end
        for i ∈ 3:2:trunc(Int, sqrt(n))
            if sieve[i]
                for j ∈ i*i:2*i:n
                    sieve[j] = false
                end
            end
        end
        return sieve
    end

    get_primes(n::Int64)::Array{Int64, 1} = findall(get_primality(n))

    function smallest_prime_factor(n::Int64)::Int64
        primes = get_primes(trunc(Int, sqrt(n)))
        for prime ∈ primes
            if n % prime == 0
                return prime
            end
        end
        return n
    end

    function is_prime(n::Int64)::Bool
        if n < 2
            return false
        elseif n < 4
            return true
        elseif (n % 2 == 0) | (n % 3 == 0)
            return false
        end
        for i ∈ 6:6:trunc(Int64, √n + 1)
            if (n % (i - 1) == 0) | (n % (i + 1) == 0)
                return false
            end
        end
        return true
    end
end
