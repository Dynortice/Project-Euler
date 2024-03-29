using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    for c ∈ n ÷ 3 + 1:n ÷ 2
        s = c * c - n * n + 2n * c
        if s > 0
            t = trunc(Int, √s)
            if t * t == s
                b = (n - c + t) / 2
                a = n - c - b
                return a * b * c
            end
        end
    end
end

compute(12)

compute(1_000)

@benchmark compute(1_000)
