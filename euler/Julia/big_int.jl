mutable struct Big_Int
    str::AbstractString
    positive::Bool

    function Big_Int(str::AbstractString)
        if str ≠ ""
            str[1] ≡ '-' ? new(str[2:end], false) : new(str, true)
        else
            new("0", true)
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

Base.show(io::IO, x::Big_Int) = show(io, x.str)

Base.copy(x::Big_Int) = Big_Int(string(x.positive ? "" : "-", x.str))

Base.length(x::Big_Int) = length(x.str)

Base.getindex(x::Big_Int, i::Int64) = getindex(x.str, i)

Base.getindex(x::Big_Int, r::UnitRange{Int64}) = getindex(x.str, r)

Base.lastindex(x::Big_Int) = lastindex(x.str)

Base.:-(x::Big_Int) = Big_Int(string("-", x.str))

function Base.isless(x::Big_Int, y::Big_Int)
    if x.positive ≡ y.positive
        if length(x) ≡ length(y)
            if x.str ≡ y.str
                return false
            else
                for i in 1:length(x)
                    if x[i] ≡ y[i]
                        continue
                    else
                        return (x[i] < y[i]) & x.positive
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

function Base.:(==)(x::Big_Int, y::Big_Int)
    return (x.str ≡ y.str) & (x.positive ≡ y.positive)
end

function Base.:+(x::Big_Int, y::Big_Int)
    if x.positive ≡ y.positive
        a, b = zero_pad(x.str, y.str, false)
        result = ""
        carry = 0
        for i in 1:Int(ceil(length(a) / 18))
            carry += parse(Int, a[max(end - 18 * i + 1, 1):end - 18 * (i - 1)]) + parse(Int, b[max(end - 18 * i + 1, 1):end - 18 * (i - 1)])
            result = string(repeat('0', max(18 - length(string(carry)), 0)), string(carry)[max(end - 17, 1):end], result)
            carry ÷= 10 ^ 18
        end
        if carry ≡ 0
            result = lstrip(result, '0')
        else
            result = string(carry, result)
        end
        if x.positive
            return Big_Int(result)
        else
            return Big_Int(string('-', result))
        end
    else
        if x.positive
            return x - -y
        else
            return y - -x
        end
    end
end

function Base.:-(x::Big_Int, y::Big_Int)
    if x.positive ≡ y.positive
        if x == y
            return Big_Int("0")
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
            for i in 1:Int(ceil(length(a) / 18))
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
            if positive
                return Big_Int(result)
            else
                return Big_Int(string('-', result))
            end
        end
    else
        if x.positive
            return x + -y
        else
            return -(-x + y)
        end
    end
end

function Base.:*(x::Big_Int, y::Big_Int)
    function mul(e::Big_Int, f::Big_Int)::Big_Int
        if max(length(e), length(f)) < 10
            return e.positive ≡ f.positive ? Big_Int(string(parse(Int, e.str) * parse(Int, f.str))) : Big_Int(string('-', parse(Int, e.str) * parse(Int, f.str)))
        end
        g, h = reverse(e.str), reverse(f.str)
        result = Big_Int("0")
        for i in 1:length(g)
            carry = 0
            sub_result = repeat('0', i - 1)
            for j in 1:length(h)
                carry += parse(Int, g[i]) * parse(Int, h[j])
                sub_result = string(carry % 10, sub_result)
                carry ÷= 10
            end
            result += Big_Int(lstrip(string(carry, sub_result), '0'))
        end
        result.positive = e.positive ≡ f.positive
        return result
    end

    if (max(length(x), length(y)) < 10) | (min(length(x), length(y)) ≡ 1)
        return mul(x, y)
    end
    n = max(length(x), length(y))
    m = n ÷ 2
    a, b, c, d = Big_Int(x[1:end - m]), Big_Int(x[max(end - m + 1, 1):end]), Big_Int(y[1:end - m]), Big_Int(y[max(end - m + 1, 1):end])
    ac, bd, ab_cd = a * c, b * d, (a + b) * (c + d)
    r = Big_Int(pad(ac.str, 2 * m))
    s = Big_Int(pad((ab_cd - ac - bd).str, m))
    res = r + s + bd
    res.positive = x.positive ≡ y.positive
    return res
end

function Base.:^(x::Big_Int, y::Int64)
    value = copy(x)
    result = Big_Int("1")
    while y > 0
        if y % 2 ≡ 1
            result *= value
        end
        value *= value
        y ÷= 2
    end
    return result
end
