using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()
    digits_ = collect(1:9)
    for i in 9487:-1:9234
        candidate = i * 100002
        if map(x -> parse(Int64, x), sort(∪(string(candidate)))) == digits_
            return candidate
        end
    end
end

compute()

@benchmark compute()