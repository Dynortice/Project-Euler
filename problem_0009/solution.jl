using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Integer)::Integer
    for c in n ÷ 3 + 1:n ÷ 2
        s = c * c - n * n + 2 * c * n
        if s > 0
            t = trunc(Int, √s)
            if t * t ≡ s
                b = (n - c + t) / 2
                a = n - c - b
                return a * b * c
            end
        end
    end
end

compute(12)

compute(1000)

@benchmark compute(1000)
