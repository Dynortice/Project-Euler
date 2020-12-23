function compute(n::Int64)::Int64
    result = 0
    for i ∈ 1:trunc(Int64, log10(n))
        for j ∈ 10 ^ trunc(Int64, ceil(i / 2 - 1)):10 ^ trunc(Int64, ceil(i / 2)) - 1
            palindrome = parse(Int64, string(string(j)[1:end - i % 2], reverse(string(j))))
            binary = string(palindrome, base = 2)
            if binary == reverse(binary)
                result += palindrome
            end
        end
    end
    return result
end
