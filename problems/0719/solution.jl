using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64)::Int64
    function is_s_number(a::Int64, b::Int64)::Bool
        if a > b
            return false
        elseif a == b
            return true
        end
        modulo = 10
        while modulo < b
            quotient, remainder = b ÷ modulo, b % modulo
            if (remainder < a) & is_s_number(a - remainder, quotient)
                return true
            end
            modulo *= 10
        end
        return false
    end

    result = 0
    for i ∈ 2:n
        if is_s_number(i, i * i)
            result += i * i
        end
    end
    return result
end

compute(10 ^ 2)

compute(10 ^ 6)

@benchmark compute(10 ^ 6)