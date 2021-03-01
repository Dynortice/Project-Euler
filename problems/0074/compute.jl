using Combinatorics: with_replacement_combinations
using StatsBase: countmap

function compute(n::Int, m::Int)::Int
    factorials = map(factorial, 0:9)
    chains = Dict{Int, Int}()
    result = 0
    for combination ∈ with_replacement_combinations(9:-1:0, n)
        for _ ∈ 1:count(isequal(0), combination) + 1
            number = parse(Int, join(combination))
            chain = [number]
            term = sum(factorials[parse.(Int, collect(string(number))) .+ 1])
            while term ∉ chain
                push!(chain, term)
                if haskey(chains, term) break end
                term = sum(factorials[parse.(Int, collect(string(term))) .+ 1])
            end
            index = findfirst(isequal(term), chain)
            loop_len = haskey(chains, term) ? chains[term] : length(chain) - index + 1
            for (i, j) ∈ enumerate(chain) chains[j] = i ≥ index ? loop_len : index - i + loop_len end
            if chains[number] == m
                digits = length(combination)
                result += (digits - count(isequal(0), combination)) * factorials[digits] ÷ prod(factorials[values(countmap(combination)) .+ 1])
            end
            if 0 ∈ combination
                deleteat!(combination, findfirst(isequal(0), combination))
                if length(combination) == 0 break end
            end
        end
    end
    return result
end
