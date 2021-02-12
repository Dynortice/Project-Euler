function compute(n::Int64)::Int64
    cubes = Dict{String, Int64}()
    permutations = Dict{String, Int64}()
    for i ∈ 1:10 ^ n
        permutation = join(sort(split(string(i ^ 3), "")))
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
