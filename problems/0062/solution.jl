using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    cubes, permutations = Dict{String, Int}(), Dict{String, Int}()
    for i ∈ 1:10 ^ n
        permutation = join(sort(collect(string(i ^ 3))))
        if haskey(cubes, permutation)
            permutations[permutation] += 1
            if permutations[permutation] == n
                return cubes[permutation]
            end
        else
            cubes[permutation] = i ^ 3
            permutations[permutation] = 1
        end
    end
end

compute(3)

compute(5)

@benchmark compute(5)