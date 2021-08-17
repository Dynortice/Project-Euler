using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    perimeters = Dict{Int, Int}()
    for a ∈ 3:n÷3
        for b ∈ a:n÷2
            k = a * a + b * b
            if √k % 1 == 0
                p = a + b + trunc(Int, √k)
                if haskey(perimeters, p)
                    perimeters[p] += 1
                else
                    push!(perimeters, p => 1)
                end
            end
        end
    end
    return findmax(perimeters)[2]
end

compute(1_000)

@benchmark compute(1_000)