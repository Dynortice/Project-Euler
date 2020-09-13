module numbers
    include("calculus.jl")

    export is_palindrome, count_divisors, sum_proper_factors

    is_palindrome(n::String)::Bool = n ≡ reverse(n)

    function count_divisors(n::Int)::Int
        factors = 1
        i = 2
        while i * i ≤ n
            f = 1
            while n % i == 0
                n /= i
                f += 1
            end
            i += 1
            factors *= f
        end
        if n > 1
            factors *= 2
        end
        return factors
    end

    function sum_proper_factors(n::Integer, primes::Array{Int64, 1})::Int64
        result = 1
        number = n
        for prime in primes
            j = 1
            while number % prime == 0
                number ÷= prime
                j += 1
            end
            result *= calculus.sum_geometric_series(1, prime, j)
        end
        if number > 1
            result *= number + 1
        end
        return result - n
    end
end
