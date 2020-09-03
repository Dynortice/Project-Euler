function compute(n::Integer, digits::String)::Integer
    digits = [parse(Int, digit) for digit in replace(digits, "\n" => "")]
    max_product = 0
    for i in 1:length(digits) - n + 1
        if 0 in digits[i:i+n-1]
            continue
        end
        cur_product = prod(digits[i:i+n-1])
        if cur_product > max_product
            max_product = cur_product
        end
    end
    return max_product
end
