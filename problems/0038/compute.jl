function compute()::Int64
    digits_ = collect(1:9)
    for i ∈ 9487:-1:9234
        candidate = i * 100002
        if map(x -> parse(Int64, x), sort(∪(string(candidate)))) == digits_
            return candidate
        end
    end
end