module numbers
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
end
