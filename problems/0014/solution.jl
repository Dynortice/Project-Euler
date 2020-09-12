include("euler/Julia/calculus.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Integer)::Integer
    result, max_chain, hashmap = 0, 0, Dict(1 => 1)
    for i in 2:n-1
        chain = calculus.len_collatz_chain(i, hashmap)
        if chain > max_chain
            result, max_chain = i, chain
        end
    end
    return result
end

compute(1000000)

@benchmark compute(1000000)