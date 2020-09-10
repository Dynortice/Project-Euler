module numbers
    is_palindrome(n::String)::Bool = n ≡ reverse(n)

    number_to_digits(n::String)::Array = [parse(Int, digit) for digit in n]

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

    function add(a::String, b::String)::String
        a, b = reverse(number_to_digits(a)), reverse(number_to_digits(b))
        if length(a) > length(b)
            append!(b, repeat([0], length(a) - length(b)))
        elseif length(b) > length(a)
            append!(a, repeat([0], length(b) - length(a)))
        end
        result = ""
        carry = 0
        for i in 1:length(a)
            carry += a[i] + b[i]
            result = string(carry % 10, result)
            carry ÷= 10
        end
        if carry ≡ 0
            return result
        else
            return string(carry, result)
        end
    end
end
