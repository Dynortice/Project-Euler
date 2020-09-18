using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64)::Int64
    result = 0
    for i in 1:trunc(Int64, log10(n))
        for j in 10 ^ trunc(Int64, ceil(i / 2 - 1)):10 ^ trunc(Int64, ceil(i / 2)) - 1
            palindrome = parse(Int64, string(string(j)[1:end - i % 2], reverse(string(j))))
            binary = string(palindrome, base = 2)
            if binary ≡ reverse(binary)
                result += palindrome
            end
        end
    end
    return result
end

compute(1000000)

@benchmark compute(1000000)