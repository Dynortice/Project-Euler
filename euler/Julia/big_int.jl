module BigIntegers
    export BigInteger

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

    pad(a::AbstractString, n::Int64, right::Bool = true)::String = right ? string(a, repeat("0", n)) : string(repeat("0", n), a)

    function zero_pad(a::AbstractString, b::AbstractString, right::Bool = true)::Tuple{String, String}
        if length(a) > length(b)
            b = pad(b, length(a) - length(b), right)
        elseif length(b) > length(a)
            a = pad(a, length(b) - length(a), right)
        end
        return a, b
    end

    Base.show(io::IO, x::BigInteger) = show(io, string(x.positive ? "" : "-", x.str))

    Base.copy(x::BigInteger)::BigInteger = BigInteger(x.str, x.positive)

    Base.length(x::BigInteger)::Int64 = length(x.str)

    Base.getindex(x::BigInteger, i::Int64)::Char = getindex(x.str, i)

    Base.getindex(x::BigInteger, r::UnitRange{Int64})::SubString = getindex(x.str, r)

    Base.lastindex(x::BigInteger)::Int64 = lastindex(x.str)

    Base.:-(x::BigInteger)::BigInteger = BigInteger(x.str, !x.positive)

    Base.abs(x::BigInteger)::BigInteger = BigInteger(x.str, true)

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

    Base.:<(x::BigInteger, y::Int64)::Bool = x < BigInteger(y)
    Base.:<(x::Int64, y::BigInteger)::Bool = BigInteger(x) < y

    function Base.:(==)(x::BigInteger, y::BigInteger)::Bool
        return (x.str == y.str) & (x.positive == y.positive)
    end

    Base.:(==)(x::BigInteger, y::Int64)::Bool = x == BigInteger(y)

    function Base.:+(x::BigInteger, y::BigInteger)::BigInteger
        if x.positive == y.positive
            a, b = zero_pad(x.str, y.str, false)
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

    Base.:+(x::BigInteger, y::Int64)::BigInteger = x + BigInteger(y)
    Base.:+(x::Int64, y::BigInteger)::BigInteger = BigInteger(x) + y

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
                a, b = zero_pad(a, b, false)
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

    Base.:-(x::BigInteger, y::Int64)::BigInteger = x - BigInteger(y)
    Base.:-(x::Int64, y::BigInteger)::BigInteger = BigInteger(x) - y

    function Base.:*(x::BigInteger, y::BigInteger)::BigInteger
        function mul(e::BigInteger, f::BigInteger)::BigInteger
            if max(length(e), length(f)) < 10
                return BigInteger(string(parse(Int, e.str) * parse(Int, f.str)), e.positive == f.positive)
            end
            g, h = reverse(e.str), reverse(f.str)
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
            result.positive = e.positive == f.positive
            return result
        end

        if (max(length(x), length(y)) < 10) | (min(length(x), length(y)) == 1)
            return mul(x, y)
        end
        n = max(length(x), length(y))
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

    Base.:*(x::BigInteger, y::Int64)::BigInteger = x * BigInteger(y)
    Base.:*(x::Int64, y::BigInteger)::BigInteger = BigInteger(x) * y

    function Base.:÷(x::BigInteger, y::BigInteger)::BigInteger
        if abs(x) < abs(y)
            result = BigInteger(0)
        else
            value = copy(y)
            multipliers = Dict(1 => copy(value))
            i = 1
            while abs(x) > abs(value)
                value *= 2
                i *= 2
                multipliers[i] = copy(value)
            end
            value = copy(multipliers[1])
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

    Base.:÷(x::BigInteger, y::Int64)::BigInteger = x ÷ BigInteger(y)

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

    Base.:%(x::BigInteger, y::Int64)::BigInteger = x % BigInteger(y)

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

    Base.:^(x::BigInteger, p::Int64) = x ^ BigInteger(p)
    Base.:^(x::Int64, p::BigInteger) = BigInteger(x) ^ p

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

    Base.powermod(x::BigInteger, p::Int64, m::BigInteger) = powermod(x, BigInteger(p), m)
    Base.powermod(x::BigInteger, p::BigInteger, m::Int64) = powermod(x, p, BigInteger(m))
    Base.powermod(x::BigInteger, p::Int64, m::Int64) = powermod(x, BigInteger(p), BigInteger(m))
    Base.powermod(x::Int64, p::BigInteger, m::BigInteger) = powermod(BigInteger(x), p, m)
    Base.powermod(x::Int64, p::Int64, m::BigInteger) = powermod(BigInteger(x), BigInteger(p), m)
    Base.powermod(x::Int64, p::BigInteger, m::Int64) = powermod(BigInteger(x), p, BigInteger(m))
end