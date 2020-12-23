module Numbers
    include("big_int.jl")
    include("calculus.jl")
    using .BigIntegers: BigInteger
    using .Calculus: sum_geometric_series

    export is_palindrome, is_perfect_squre, count_divisors, sum_proper_factors, multiplicative_order

    is_palindrome(n::Int64)::Bool = string(n) == reverse(string(n))
    is_palindrome(n::BigInteger)::Bool = n.str == reverse(n.str)

    is_perfect_square(n::Int64)::Bool = trunc(Int64, √n) ^ 2 == n

    function count_divisors(n::Int64)::Int64
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

    function sum_proper_factors(n::Int64, primes::Array{Int64, 1})::Int64
        result = 1
        number = n
        for prime ∈ primes
            j = 1
            while number % prime == 0
                number ÷= prime
                j += 1
            end
            result *= sum_geometric_series(1, prime, j)
        end
        if number > 1
            result *= number + 1
        end
        return result - n
    end

    function multiplicative_order(a::Int64, n::Int64)::Int64
        i, k = 1, a
        while (k ≠ 1) & (i < n)
            k = k * a % n
            i += 1
        end
        return i
    end
end
