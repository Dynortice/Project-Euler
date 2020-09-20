module primes

    export get_primality, get_primes, smallest_prime_factor

    function get_primality(n::Integer)::Array{Bool, 1}
        sieve = repeat([true], n)
        sieve[1] = false
        for i in 4:2:n
            sieve[i] = false
        end
        for i in 3:2:trunc(Int, sqrt(n))
            if sieve[i]
                for j in i*i:2*i:n
                    sieve[j] = false
                end
            end
        end
        return sieve
    end

    get_primes(n::Integer)::Array{Int64, 1} = findall(get_primality(n))

    function smallest_prime_factor(n::Integer)::Integer
        primes = get_primes(trunc(Int, sqrt(n)))
        for prime in primes
            if n % prime == 0
                return prime
            end
        end
        return n
    end
end
