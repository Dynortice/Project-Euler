using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int
    digits = collect(1:9)
    for i ∈ 9_487:-1:9_234
        candidate = i * 100_002
        if parse.(Int, sort(∪(string(candidate)))) == digits
            return candidate
        end
    end
end

compute()

@benchmark compute()