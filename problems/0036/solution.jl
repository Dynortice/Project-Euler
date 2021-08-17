using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    result = 0
    for i ∈ 1:trunc(Int, log10(n))
        for j ∈ 10 ^ trunc(Int, ceil(i / 2 - 1)):10 ^ trunc(Int, ceil(i / 2)) - 1
            palindrome = parse(Int, string(string(j)[1:end - i % 2], reverse(string(j))))
            binary = string(palindrome, base = 2)
            if binary == reverse(binary)
                result += palindrome
            end
        end
    end
    return result
end

compute(1_000_000)

@benchmark compute(1_000_000)