function compute(d::Int64)::Int64
    digits_number(k::Int64)::Int64 = (10 ^ k * (9 * k - 1) + 1) ÷ 9
    function get_digit(n::Int64)::Int64
        k = 0
        while digits_number(k + 1) < n
            k += 1
        end
        k += 1
        rem = n - digits_number(k - 1)
        num = 10 ^ (k - 1) + rem ÷ k - 1
        if rem % k == 0
            return parse(Int64, string(num)[end])
        else
            return parse(Int64, string(num + 1)[rem % k])
        end
    end
    return prod([get_digit(10 ^ i) for i ∈ 0:d])
end