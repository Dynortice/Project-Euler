function compute(n::Float64)::Int64
    function is_bouncy(x::Int64)::Bool
        digits = string(x)
        sorted_digits = join(sort(split(digits, "")))
        if digits == sorted_digits || digits == reverse(sorted_digits)
            return false
        else
            return true
        end
    end
    bouncy = 0
    i = 1
    while true
        bouncy += is_bouncy(i)
        if bouncy / i ≥ n
            return i
        end
        i += 1
    end
end
