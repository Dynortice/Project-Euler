using Combinatorics: with_replacement_combinations
using StatsBase: countmap
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64, m::Int64)::Int64
    get_next_term(k::Int64)::Int64 = sum(factorials[i + 1] for i ∈ parse.(Int64, split(string(k), "")))
    function get_chain_len(k::Int64)::Int64
        if haskey(chains, k)
            return chains[k]
        end
        term = k
        chain = [term]
        term = get_next_term(term)
        while term ∉ chain
            push!(chain, term)
            if haskey(chains, term)
                break
            end
            term = get_next_term(term)
        end
        index_term = findfirst(isequal(term), chain)
        loop_len = haskey(chains, term) ? chains[term] : length(chain) - index_term + 1
        for (i, j) ∈ enumerate(chain)
            if i ≥ index_term
                chains[j] = loop_len
            else
                chains[j] = index_term - i + loop_len
            end
        end
        return chains[k]
    end
    factorials = map(factorial, 0:9)
    chains = Dict{Int64, Int64}()
    result = 0
    for combination ∈ with_replacement_combinations(9:-1:0, n)
        for _ ∈ 1:count(isequal(0), combination) + 1
            if get_chain_len(parse(Int64, join(combination))) == m
                n_digits = length(combination)
                n_zeros = count(isequal(0), combination)
                counter = countmap(combination)
                result += (n_digits - n_zeros) * factorials[n_digits] ÷ prod(factorials[i + 1] for i ∈ values(counter))
            end
            if 0 ∈ combination
                deleteat!(combination, findfirst(isequal(0), combination))
                if length(combination) == 0
                    break
                end
            end
        end
    end
    return result
end

compute(6, 60)

@benchmark compute(6, 60)