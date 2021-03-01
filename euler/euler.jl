module BigIntegers
    mutable struct BigInteger
        str::AbstractString
        positive::Bool

        BigInteger(str::AbstractString, positive::Bool) = new(str == "" ? "0" : str, positive)
        BigInteger(x::Int64) = new(string(abs(x)), x ≥ 0)
        BigInteger(x::BigInteger) = copy(x)
        function BigInteger(x::AbstractString)
            if x == ""
                new("0", true)
            else
                if x[1] == '-'
                    new(x[2:end], false)
                else
                    new(x, true)
                end
            end
        end
    end

    pad(s::AbstractString, n::Int, right::Bool = true)::String = right ? string(s, repeat("0", n)) : string(repeat("0", n), s)

    function align_strings(a::AbstractString, b::AbstractString, right::Bool = true)::Tuple{String, String}
        if length(a) > length(b)
            b = pad(b, length(a) - length(b), right)
        elseif length(b) > length(a)
            a = pad(a, length(b) - length(a), right)
        end
        return a, b
    end


    function mul_s(a::BigInteger, b::BigInteger)::BigInteger
        if length(a) + length(b) < 19
            return BigInteger(string(parse(Int, a.str) * parse(Int, b.str)), a.positive == b.positive)
        end
        g, h = reverse(a.str), reverse(b.str)
        result = BigInteger(0)
        for i ∈ 1:length(g)
            carry = 0
            sub_result = repeat('0', i - 1)
            for j ∈ 1:length(h)
                carry += parse(Int, g[i]) * parse(Int, h[j])
                sub_result = string(carry % 10, sub_result)
                carry ÷= 10
            end
            result += BigInteger(lstrip(string(carry, sub_result), '0'), true)
        end
        result.positive = a.positive == b.positive
        return result
    end

    Base.show(io::IO, x::BigInteger)::Nothing = show(io, string(x.positive ? "" : "-", x.str))

    Base.copy(x::BigInteger)::BigInteger = BigInteger(x.str, x.positive)

    Base.length(x::BigInteger)::Int = length(x.str)

    Base.getindex(x::BigInteger, i::Int)::Char = getindex(x.str, i)

    Base.getindex(x::BigInteger, r::UnitRange{Int})::SubString = getindex(x.str, r)

    Base.lastindex(x::BigInteger)::Int = lastindex(x.str)

    Base.:-(x::BigInteger)::BigInteger = BigInteger(x.str, !x.positive)

    Base.abs(x::BigInteger)::BigInteger = BigInteger(x.str, true)

    Base.isless(x::BigInteger, y::BigInteger)::Bool = x < y

    Base.hash(x::BigInteger)::UInt = hash(x.str)

    function Base.:<(x::BigInteger, y::BigInteger)::Bool
        if x.positive == y.positive
            if length(x) == length(y)
                if x.str == y.str
                    return false
                else
                    for i ∈ 1:length(x)
                        if x[i] == y[i]
                            continue
                        else
                            return !((x[i] < y[i]) ⊻ x.positive)
                        end
                    end
                end
            else
                return !((length(x) < length(y)) ⊻ x.positive)
            end
        else
            return !x.positive
        end
    end

    Base.:<(x::BigInteger, y::Int)::Bool = x < BigInteger(y)
    Base.:<(x::Int, y::BigInteger)::Bool = BigInteger(x) < y

    Base.:(==)(x::BigInteger, y::BigInteger)::Bool = x.str == y.str && x.positive == y.positive
    Base.:(==)(x::BigInteger, y::Int)::Bool = x == BigInteger(y)

    function Base.:+(x::BigInteger, y::BigInteger)::BigInteger
        if x.positive == y.positive
            a, b = align_strings(x.str, y.str, false)
            result = ""
            carry = 0
            for i ∈ 1:Int(ceil(length(a) / 18))
                carry += parse(Int, a[max(end - 18 * i + 1, 1):end - 18 * (i - 1)]) + parse(Int, b[max(end - 18 * i + 1, 1):end - 18 * (i - 1)])
                result = string(repeat('0', max(18 - length(string(carry)), 0)), string(carry)[max(end - 17, 1):end], result)
                carry ÷= 10 ^ 18
            end
            if carry == 0
                result = lstrip(result, '0')
            else
                result = string(carry, result)
            end
            return BigInteger(result, x.positive)
        else
            if x.positive
                return x - -y
            else
                return y - -x
            end
        end
    end

    Base.:+(x::BigInteger, y::Int)::BigInteger = x + BigInteger(y)
    Base.:+(x::Int, y::BigInteger)::BigInteger = BigInteger(x) + y

    function Base.:-(x::BigInteger, y::BigInteger)::BigInteger
        if x.positive == y.positive
            if x == y
                return BigInteger(0)
            else
                if x.positive
                    if x > y
                        positive = true
                        a, b = x.str, y.str
                    else
                        positive = false
                        a, b = y.str, x.str
                    end
                else
                    if x > y
                        positive = true
                        a, b = y.str, x.str
                    else
                        positive = false
                        a, b = x.str, y.str
                    end
                end
                a, b = align_strings(a, b, false)
                result = ""
                carry = 0
                for i ∈ 1:Int(ceil(length(a) / 18))
                    carry += parse(Int, a[max(end - 18 * i + 1, 1):end - 18 * (i - 1)]) - parse(Int, b[max(end - 18 * i + 1, 1):end - 18 * (i - 1)])
                    if carry < 0
                        result = string(repeat('0', 18 - length(string(10 ^ 18 + carry))), 10 ^ 18 + carry, result)
                        carry = -1
                    else
                        result = string(repeat('0', 18 - length(string(carry))), carry, result)
                        carry = 0
                    end
                end
                result = lstrip(result, '0')
                return BigInteger(result, positive)
            end
        else
            if x.positive
                return x + -y
            else
                return -(-x + y)
            end
        end
    end

    Base.:-(x::BigInteger, y::Int)::BigInteger = x - BigInteger(y)
    Base.:-(x::Int, y::BigInteger)::BigInteger = BigInteger(x) - y

    function Base.:*(x::BigInteger, y::BigInteger)::BigInteger
        x_len, y_len = length(x), length(y)
        if x_len + y_len < 19 || x_len == 1 || y_len == 1 return mul_s(x, y) end
        n = x_len > y_len ? x_len : y_len
        m = n ÷ 2
        a, b = BigInteger(x[1:end - m], true), BigInteger(x[max(end - m + 1, 1):end], true)
        c, d = BigInteger(y[1:end - m], true), BigInteger(y[max(end - m + 1, 1):end], true)
        ac, bd, ab_cd = a * c, b * d, (a + b) * (c + d)
        r = BigInteger(pad(ac.str, 2 * m), true)
        s = BigInteger(pad((ab_cd - ac - bd).str, m), true)
        res = r + s + bd
        res.positive = x.positive == y.positive
        return res
    end

    Base.:*(x::BigInteger, y::Int)::BigInteger = x * BigInteger(y)
    Base.:*(x::Int, y::BigInteger)::BigInteger = BigInteger(x) * y

    function Base.:÷(x::BigInteger, y::BigInteger)::BigInteger
        if abs(x) < abs(y)
            result = BigInteger(0)
        else
            value = copy(y)
            multipliers = Dict(BigInteger(1) => copy(value))
            i = BigInteger(1)
            while abs(x) > abs(value)
                value *= 2
                i *= 2
                multipliers[i] = copy(value)
            end
            value = copy(multipliers[BigInteger(1)])
            result = BigInteger(1)
            for i ∈ reverse(sort(collect(keys(multipliers))))
                if value + multipliers[i] ≤ abs(x)
                    result += i
                    value += multipliers[i]
                end
            end
        end
        return x.positive == y.positive ? result : -(result + 1)
    end

    Base.:÷(x::BigInteger, y::Int)::BigInteger = x ÷ BigInteger(y)

    function Base.:%(x::BigInteger, y::BigInteger)::BigInteger
        if x.str == y.str
            return BigInteger(0)
        elseif abs(x) > abs(y)
            return x - x ÷ y * y
        elseif x.positive == y.positive
            return copy(x)
        else
            return x + y
        end
    end

    Base.:%(x::BigInteger, y::Int)::BigInteger = x % BigInteger(y)

    function Base.:^(x::BigInteger, p::BigInteger)
        value = copy(x)
        result = BigInteger(1)
        while p > 0
            if p % 2 == 1
                result *= value
            end
            value *= value
            p ÷= 2
        end
        return result
    end

    Base.:^(x::BigInteger, p::Int) = x ^ BigInteger(p)
    Base.:^(x::Int, p::BigInteger) = BigInteger(x) ^ p

    function Base.powermod(x::BigInteger, p::BigInteger, m::BigInteger)
        value = copy(x)
        result = BigInteger(1)
        while p > 0
            if p % 2 == 1
                result *= value
                result %= m
            end
            value *= value
            value %= m
            p ÷= 2
        end
        return result
    end

    Base.powermod(x::BigInteger, p::Int, m::BigInteger) = powermod(x, BigInteger(p), m)
    Base.powermod(x::BigInteger, p::BigInteger, m::Int) = powermod(x, p, BigInteger(m))
    Base.powermod(x::BigInteger, p::Int, m::Int) = powermod(x, BigInteger(p), BigInteger(m))
    Base.powermod(x::Int, p::BigInteger, m::BigInteger) = powermod(BigInteger(x), p, m)
    Base.powermod(x::Int, p::Int, m::BigInteger) = powermod(BigInteger(x), BigInteger(p), m)
    Base.powermod(x::Int, p::BigInteger, m::Int) = powermod(BigInteger(x), p, BigInteger(m))
end

module Calculus
    """
        sum_arithmetic_series(a::Real, d::Real, n::Int)

    Get sum of first `n` terms of arithmetic series

    # Arguments
    - `n::Real`: First number in series
    - `d::Real`: Common difference of series
    - `n::Int`: Number of terms in series

    # Examples
    ```
    julia> sum_arithmetic_series(1, 2, 3)
    9.0
    julia> sum_arithmetic_series(0.5, 0.75, 3)
    3.75
    ```
    """
    sum_arithmetic_series(a::Real, d::Real, n::Int)::Float64 = 0.5n * (2a + d * (n - 1))

    """
        sum_geometric_series(a::Real, r::Real, n::Int)

    Get sum of `n` first terms of geometric series

    # Arguments

    - `a::Real`: First number in series
    - `r::Real`: Common ratio of series
    - `n::Int`: Number of terms in series

    # Examples
    ```
    julia> sum_geometric_series(1, 2, 3)
    7.0
    julia> sum_geometric_series(0.5, 0.75, 3)
    1.15625
    ```
    """
    sum_geometric_series(a::Real, r::Real, n::Int)::Float64 = a * (r ^ n - 1) / (r - 1)

    """
        fibonacci_numbers(n::Int, T::Type=Int)

    Generate `n` first Fibonacci numbers [OEIS A000045](https://oeis.org/A000045)

    # Arguments

    - `n::Int`: Number of Fibonacci numbers
    - `T::Type`: Type of numbers

    # Examples
    ```
     julia> fibonacci_numbers(10)
     10-element Array{Int64,1}:
      1
      1
      2
      3
      5
      8
     13
     21
     34
     55
    julia> fibonacci_numbers(10, BigInteger)
    11-element Array{BigInteger,1}:
     "1"
     "1"
     "2"
     "3"
     "5"
     "8"
     "13"
     "21"
     "34"
     "55"
    ```
    """
    function fibonacci_numbers(n::Int, T::Type=Int)::Array{T, 1}
        f_prev, f_curr = T(1), T(1)
        result = [f_prev, f_curr]
        for i ∈ 1:n - 2
            f_prev, f_curr = f_curr, f_prev + f_curr
            push!(result, f_curr)
        end
        return result
    end

    """
        get_fibonacci(n::Int)

    Get `n`-th Fibonacci number

    # Arguments

    - `n::Int`: Index of Fibonacci number

    # Examples
    ```
    julia> get_fibonacci(10)
    55
    ```
    """
    get_fibonacci(n::Int)::Int = trunc(Int, ((1 + √5) / 2) ^ n / √5 + 0.5)

    """
        fibonacci_index(n::Int)

    Get index of `n` in Fibonacci sequence

    # Examples
    ```
    julia> fibonacci_index(55)
    10
    julia> fibonacci_index(54)
    9
    ```
    """
    fibonacci_index(n::Int)::Int = trunc(Int, log((1 + √5) / 2, √5n + 0.5))

    """
        len_collatz_chain(n::Int, hashmap::Dict{Int, Int})

    Get length of Collatz chain

    # Arguments
    - `n::Int`: Starting number
    - `hashmap::Dict{Int, Int}`: Collatz chains lengths

    # Examples
    ```
    julia> len_collatz_chain(13, Dict(1 => 1))
    10
    ```
    """
    function len_collatz_chain(n::Int, hashmap::Dict{Int, Int})::Int
        if !haskey(hashmap, n)
            if n % 2 == 0
                hashmap[n] = 1 + len_collatz_chain(n ÷ 2, hashmap)
            else
                hashmap[n] = 2 + len_collatz_chain((3n + 1) ÷ 2, hashmap)
            end
        end
        return hashmap[n]
    end

    """
        triangular_numbers(n::Int)

    Generate `n` first numbers in triangular numbers sequence [OEIS A000217](<https://oeis.org/A000217>)

    # Arguments

    - `n::Int`: Number of triangular numbers

    # Examples
    ```
    julia> triangular_numbers(10)
    10-element Array{Int64,1}:
      1
      3
      6
     10
     15
     21
     28
     36
     45
     55
    ```
    """
    function triangular_numbers(n::Int)::Array{Int, 1}
        result = [1]
        for i ∈ 2:n
            push!(result, result[end] + i)
        end
        return result
    end

    """
        get_triangular(n::Int)

    Get `n`-th triangular number

    # Arguments

    - `n::Int`: Index of triangular number

    # Examples
    ```
    julia> get_triangular(10)
    55
    ```
    """
    get_triangular(n::Int)::Int = n * (n + 1) ÷ 2

    """
        triangular_index(n::Int)

    Get index of `n` in triangular sequence

    # Examples
    ```
    julia> triangular_index(55)
    10
    julia> triangular_index(54)
    9
    ```
    """
    triangular_index(n::Int)::Int = (√(8n + 1) - 1) ÷ 2

    """
        is_triangular(n::Int)

    Check if number is triangular

    # Examples
    ```
    julia> is_triangular(55)
    true
    julia> is_triangular(54)
    false
    ```
    """
    is_triangular(n::Int)::Bool = √(8n + 1) % 2 == 1

    """
        square_numbers(n::Int)

    Generate `n` first numbers in square numbers sequence [OEIS A000290](<https://oeis.org/A000290>)

    # Arguments

    - `n::Int`: Number of square numbers

    # Examples
    ```
    julia> square_numbers(10)
    10-element Array{Int64,1}:
       1
       4
       9
      16
      25
      36
      49
      64
      81
     100
    ```
    """
    square_numbers(n::Int)::Array{Int, 1} = (1:n) .^ 2

    """
        get_square(n::Int)

    Get `n`-th square number

    # Arguments

    - `n::Int`: Index of square number

    # Examples
    ```
    julia> get_square(10)
    100
    ```
    """
    get_square(n::Int)::Int = n * n

    """
        square_index(n::Int)

    Get index of `n` in square sequence

    # Examples
    ```
    julia> square_index(100)
    10
    julia> square_index(99)
    9
    ```
    """
    square_index(n::Int)::Int = trunc(Int, √n)

    """
        is_square(n::Int)

    Check if number is square

    # Examples
    ```
    julia> is_square(100)
    true
    julia> is_square(99)
    false
    ```
    """
    is_square(n::Int)::Bool = √n % 1 == 0

        """
        pentagonal_numbers(n::Int)

    Generate `n` first numbers in pentagonal numbers sequence [OEIS A000326](<https://oeis.org/A000326>)

    # Arguments

    - `n::Int`: Number of pentagonal numbers

    # Examples
    ```
    julia> pentagonal_numbers(10)
    10-element Array{Int64,1}:
       1
       5
      12
      22
      35
      51
      70
      92
     117
     145
    ```
    """
    function pentagonal_numbers(n::Int)::Array{Int, 1}
        result = [1]
        for i ∈ 4:3:3n
            push!(result, result[end] + i)
        end
        return result
    end

    """
        get_pentagonal(n::Int)

    Get `n`-th pentagonal number

    # Arguments

    - `n::Int`: Index of pentagonal number

    # Examples
    ```
    julia> get_pentagonal(10)
    145
    ```
    """
    get_pentagonal(n::Int)::Int = n * (3 * n - 1) ÷ 2

    """
        pentagonal_index(n::Int)

    Get index of `n` in pentagonal sequence

    # Examples
    ```
    julia> pentagonal_index(145)
    10
    julia> pentagonal_index(144)
    9
    ```
    """
    pentagonal_index(n::Int)::Int = (√(24n + 1) + 1) ÷ 6

    """
        is_pentagonal(n::Int)

    Check if number is pentagonal

    # Examples
    ```
    julia> is_pentagonal(145)
    true
    julia> is_pentagonal(144)
    false
    ```
    """
    is_pentagonal(n::Int)::Bool = √(24n + 1) % 6 == 5

        """
        hexagonal_numbers(n::Int)

    Generate `n` first numbers in hexagonal numbers sequence [OEIS A000384](<https://oeis.org/A000384>)

    # Arguments

    - `n::Int`: Number of hexagonal numbers

    # Examples
    ```
    julia> hexagonal_numbers(10)
    10-element Array{Int64,1}:
       1
       6
      15
      28
      45
      66
      91
     120
     153
     190
    ```
    """
    function hexagonal_numbers(n::Int)::Array{Int, 1}
        result = [1]
        for i ∈ 5:4:4n
            push!(result, result[end] + i)
        end
        return result
    end

    """
        get_hexagonal(n::Int)

    Get `n`-th hexagonal number

    # Arguments

    - `n::Int`: Index of hexagonal number

    # Examples
    ```
    julia> get_hexagonal(10)
    190
    ```
    """
    get_hexagonal(n::Int)::Int = n * (2n - 1)

    """
        hexagonal_index(n::Int)

    Get index of `n` in hexagonal sequence

    # Examples
    ```
    julia> hexagonal_index(190)
    10
    julia> hexagonal_index(189)
    9
    ```
    """
    hexagonal_index(n::Int)::Int = (√(8n + 1) + 1) ÷ 4

    """
        is_hexagonal(n::Int)

    Check if number is hexagonal

    # Examples
    ```
    julia> is_hexagonal(190)
    true
    julia> is_hexagonal(189)
    false
    ```
    """
    is_hexagonal(n::Int)::Bool = √(8n + 1) % 4 == 3

    """
        champernowne_digits(n::Int)

    Get number of digits formed by `n`-digit numbers in Champernowne constant

    # Examples
    julia> champernowne_digits(3)
    2889
    """
    champernowne_digits(n::Int)::Int = (10 ^ n * (9n - 1) + 1) ÷ 9
end

module Math
    using ..BigIntegers: BigInteger

    """
        fast_max(a::Int, b::Int)

    Get max between two numbers

    # Examples:
    julia> fast_max(100, 50)
    100
    """
    fast_max(a::Int, b::Int)::Int = a > b ? a : b

    """
        fast_max(a::BigInteger, b::BigInteger)

    Get max between two numbers

    # Examples:
    julia> fast_max(BigInteger(48), BigInteger(49))
    "49"
    """
    fast_max(a::BigInteger, b::BigInteger)::BigInteger = a > b ? a : b

    """
        fast_min(a::Int, b::Int)

    Get min between two numbers

    # Examples:
    julia> fast_min(100, 50)
    50
    """
    fast_min(a::Int, b::Int)::Int = a < b ? a : b

    """
        fast_min(a::BigInteger, b::BigInteger)

    Get min between two numbers

    # Examples:
    julia> fast_min(BigInteger(48), BigInteger(49))
    "48"
    """
    fast_min(a::BigInteger, b::BigInteger)::BigInteger = a < b ? a : b
end

module Grid
    using ..Math: fast_max

    """
        adjacent_product(grid::Array{Array{Int, 1}, 1}, n::Int, coordinate::Tuple{Int, Int},
                         direction::Tuple{Int, Int})

    Get product of `n` adjacent numbers in `grid`

    # Arguments:
    - `grid::Array{Array{Int, 1}, 1}`: Matrix-like array
    - `n::Int`: Number of adjacent numbers in product
    - `coordinate::Tuple{Int, Int}`: Start position in product
    - `direction::Tuple{Int, Int}`: Direction for getting adjacent numbers (vertical, horizontal, diagonal)

    # Examples:
    julia> grid = [[8, 2, 22, 97], [49, 49, 99, 40], [81, 49, 31, 73], [52, 70, 95, 23]]
    4-element Array{Array{Int64,1},1}:
     [8, 2, 22, 97]
     [49, 49, 99, 40]
     [81, 49, 31, 73]
     [52, 70, 95, 23]
    Horizontal (8 * 2 * 22 * 97):
    julia> adjacent_product(grid, 4, (1, 1), (1, 0))
    34144
    Vertical (97 * 40 * 73):
    julia> adjacent_product(grid, 3, (4, 1), (0, 1))
    283240
    Up-left to down-right diagonal (49 * 31 * 23)
    julia> adjacent_product(grid, 3, (2, 2), (1, 1))
    34937
    Up-right to down-left diagonal (97 * 99)
    julia> adjacent_product(grid, 2, (4, 1), (-1, 1))
    9603
    """
    function adjacent_product(grid::Array{Array{Int, 1}, 1}, n::Int, coordinate::Tuple{Int, Int},
                              direction::Tuple{Int, Int})::Int
        product = 1
        for i ∈ 0:n - 1
            number = grid[coordinate[2] + direction[2] * i][coordinate[1] + direction[1] * i]
            if number == 0
                return 0
            end
            product *= number
        end
        return product
    end

    """
        grid::Array{Array{Int, 1}, 1}

    Get triangle maximum path sum

    # Arguments:
    - `grid::Array{Array{Int, 1}, 1}`: Triangle-like list

    # Examples:
    julia> max_path_sum([[3], [7, 4], [2, 4, 6], [8, 5, 9, 3]])
    23
    """
    function max_path_sum(grid::Array{Array{Int, 1}, 1})::Int
        while length(grid) > 1
            for i ∈ 1:length(grid) - 1
                grid[end - 1][i] += fast_max(grid[end][i:i + 1]...)
            end
            grid = grid[1:end - 1]
        end
        return grid[1][1]
    end
end

module Numbers
    using ..BigIntegers: BigInteger
    using ..Calculus: sum_geometric_series
    """
        is_palindrome(n::Int)

    Check if Integer number is palindrome

    # Arguments
    - `n::Int`: Number

    # Examples
    ```
    julia> is_palindrome(123321)
    true
    julia> is_palindrome(123456)
    false
    ```
    """
    function is_palindrome(n::Int)::Bool
        n = string(n)
        return n == reverse(n)
    end

    """
        is_palindrome(n::BigInteger)

    Check if BigInteger number is palindrome

    # Arguments
    - `n::BigInteger`: Number

    # Examples
    ```
    julia> is_palindrome(BigInteger(123321))
    true
    julia> is_palindrome(BigInteger(123456))
    false
    ```
    """
    is_palindrome(n::BigInteger)::Bool = n.str == reverse(n.str)

    """
        count_divisors(n::Int)

    Get number of divisors of `n`

    # Arguments
    - `n::Int`: Number

    # Examples
    ```
    julia> count_divisors(23)
    2
    julia> count_divisors(284)
    6
    ```
    """
    function count_divisors(n::Int)::Int
        divisors = 1
        i = 2
        while i * i ≤ n
            f = 1
            while n % i == 0
                n /= i
                f += 1
            end
            i += 1
            divisors *= f
        end
        if n > 1; divisors *= 2 end
        return divisors
    end

    """
        sum_proper_factors(n::Int, primes::Array{Int, 1} = prime_numbers(trunc(Int, √n)))

    Get sum of proper divisors of `n`

    # Arguments
    - `n::Int`: Number
    - `primes::Array{Int, 1} = prime_numbers(trunc(Int, √n))`: Array of prime numbers below at least √n

    # Examples
    ```
    julia> sum_proper_factors(23)
    2
    julia> sum_proper_factors(284, prime_numbers(trunc(Int, √284)))
    220
    ```
    """
    function sum_proper_divisors(n::Int, primes::Array{Int, 1} = prime_numbers(trunc(Int, √n)))::Int
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
        if number > 1; result *= number + 1 end
        return result - n
    end

    """
        get_digits(n::Int)

    Get array of digits in number

    # Arguments:
    - `n::Int`: Number

    # Examples
    ```
    julia> get_digits(123)
    3-element Array{Int64,1}:
     1
     2
     3
    ```
    """
    get_digits(n::Int)::Array{Int, 1} = parse.(Int, collect(string(n)))

    """
        get_digits(n::BigInteger)

    Get array of digits in number

    # Arguments:
    - `n::BigInt`: Number

    # Examples
    ```
    julia> get_digits(BigInteger(123456))
    6-element Array{Int64,1}:
     1
     2
     3
     4
     5
     6
    ```
    """
    get_digits(n::BigInteger)::Array{Int, 1} = parse.(Int, collect(n.str))

    """
        sum_digits(n::Int)

    Get sum of digits in number

    # Arguments

    - `n::Int`: Number

    # Examples
    ```
    julia> sum_digits(123)
    6
    ```
    """
    digits_sum(n::Int)::Int = sum(get_digits(n))

    """
        sum_digits(n::BigInteger)

    Get sum of digits in number

    # Arguments

    - `n::BigInt`: Number

    # Examples
    ```
    julia> sum_digits(BigInteger(123456))
    21
    ```
    """
    digits_sum(n::BigInteger)::Int = sum(get_digits(n))

    """
        multiplicative_order(a::Int, n::Int)

    Get multiplicative order of `n` modulo `m`

    # Arguments:
    - `n::Int`: Number
    - `m::Int`: Number

    # Examples
    ```
    multiplicative_order(16, 7)
    3
    ```
    """
    function multiplicative_order(n::Int, m::Int)::Int
        i, k = 1, n
        while k ≠ 1 && i < m
            k = k * n % m
            i += 1
        end
        return i
    end

    """
        is_s_number(a::Int, b::Int)

    Check if number is S-number, that is a perfect square and its square root can be obtained by
    splitting the decimal representation of `n` into 2 or more numbers then adding the numbers.

    # Arguments
    - `a::Int`: Number
    - `b::Int`: Square of a

    # Examples
    julia> is_s_number(99, 9801)
    true
    julia> is_s_number(5, 25)
    false
    """
    function is_s_number(a::Int, b::Int)::Bool
        if a > b return false elseif a == b return true end
        m = 10
        while m < b
            quotient, remainder = b ÷ m, b % m
            if remainder < a && is_s_number(a - remainder, quotient) return true end
            m *= 10
        end
        return false
    end
end

module Primes
    """
        prime_sieve(n::Int)

    Get the sieve of primes below `n`

    # Arguments:
    - `n::Int`: Index of last prime in list

    # Examples:
    ```
    julia> prime_sieve(10)
    10-element Array{Bool,1}:
     0
     1
     1
     0
     1
     0
     1
     0
     0
     0
    ```
    """
    function prime_sieve(n::Int)::Array{Bool, 1}
        sieve = repeat([true], n)
        sieve[1] = false
        sieve[4:2:n] .= false
        for i ∈ 3:2:trunc(Int, √n)
            if sieve[i]; sieve[i*i:2i:n] .= false end
        end
        return sieve
    end

    """
        prime_numbers(n::Int)

    Generate prime numbers below `n`

    # Arguments
    - `n::Int`: Number below of which prime numbers will generate

    # Examples
    ```
    julia> prime_numbers(20)
    8-element Array{Int64,1}:
      2
      3
      5
      7
     11
     13
     17
     19
    ```
    """
    prime_numbers(n::Int)::Array{Int, 1} = findall(prime_sieve(n))

    """
        is_prime(n::Int)

    Check if number is prime

    # Arguments
    - `n::Int`: Number

    # Examples
    ```
    julia> is_prime(23)
    true
    julia> is_prime(22)
    false
    ```
    """
    function is_prime(n::Int)::Bool
        if n < 2
            return false
        elseif n < 4
            return true
        elseif n % 2 == 0 || n % 3 == 0
            return false
        end
        for i ∈ 6:6:trunc(Int, √n + 1)
            if n % (i - 1) == 0 || n % (i + 1) == 0; return false end
        end
        return true
    end

    """
        smallest_prime_factor(n::Int, primes:: Array{Int, 1} = prime_numbers(trunc(Int, √n)))

    Get smallest prime factor of number

    # Arguments
    - `n::Int`: Number
    - `primes:: Array{Int, 1} = prime_numbers(trunc(Int, √n))`: Array of primes below at least √n

    # Examples
    ```
    julia> smallest_prime_factor(23)
    23
    julia> n = 22
    julia> primes = prime_numbers(trunc(Int, √n))
    julia> smallest_prime_factor(n, primes)
    2
    ```
    """
    function smallest_prime_factor(n::Int, primes:: Array{Int, 1} = prime_numbers(trunc(Int, √n)))::Int
        for prime ∈ primes
            if n % prime == 0; return prime end
        end
        return n
    end
end

module Geometry
    """
        triangle_area(a::Array{Int, 1}, b::Array{Int, 1}, c::Array{Int, 1})

    Get area of triangle using coordinates of points

    # Examples:
    julia> triangle_area([0, 0], [0, 3], [4, 0])
    6.0
    julia> triangle_area([-23, 11], [19, 95], [-12, 114])
    1701.0
    """
    triangle_area(a::Array{Int, 1}, b::Array{Int, 1}, c::Array{Int, 1})::Float64 = abs((a[1] - c[1]) * (b[2] - a[2]) - (a[1] - b[1]) * (c[2] - a[2])) / 2
end

module Game
    """
        dice_combinations(p::Int, n::Int, s::Int)

    Get number of combinations of totals `p` for `n` `s`-sided dices

    # Arguments:
    - `p::Int`: Total sum of dices
    - `n::Int`: Number of dices
    - `s::Int`: Number of sides for each dice

    # Examples:
    julia> dice_combinations(6, 6, 6)
    1
    julia> dice_combinations(16, 8, 4)
    3823
    """
    dice_combinations(p::Int, n::Int, s::Int)::Int = sum([(-1) ^ k * binomial(n, k) * binomial(p - 1 - s * k, n - 1) for k ∈ 0:(p - n) ÷ s])
end